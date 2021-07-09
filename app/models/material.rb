# == Schema Information
#
# Table name: materials
#
#  id               :bigint           not null, primary key
#  aasm_state       :string
#  cbd              :integer
#  cost             :integer
#  description      :string
#  drought          :boolean          default(FALSE)
#  edible           :boolean          default(FALSE)
#  name             :string
#  oil              :boolean          default(FALSE)
#  terpene          :integer
#  thc              :integer
#  weight           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  material_type_id :bigint           not null
#  owner_id         :bigint           not null
#
# Indexes
#
#  index_materials_on_material_type_id  (material_type_id)
#  index_materials_on_owner_id          (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (material_type_id => material_types.id)
#  fk_rails_...  (owner_id => users.id)
#
class Material < ApplicationRecord
  include AASM

  # No direct assignment ensures that the state of the model can only be modified
  # by going through the transitions abd guards speicifed here, this way we might
  # prevent problematic hacks elsewhere in the code.
  #
  # After every error event, a specific error message is attached to exception.failures

  aasm no_direct_assignment: true, whiny_persistence: true do
    state :ready, initial: true
    state :validating_dispensary
    state :validating_stock
    state :validating_profile
    state :validating_evaluation
    state :validating_amount
    state :validating_credits

    event :reset do
      transitions to: :ready
    end

    event :start_tranfer, before: :reset do
      transitions to: :validating_dispensary
    end

    event :validate_dispensary do
      transitions to: :validating_stock, guard: :dispensary_locked?
    end

    event :validate_stock do
      transitions to: :validating_profile, guard: :stock_enough?
    end

    event :validate_receiver do
      transitions to: :validating_evaluation, guard: :receiver_valid?
    end

    event :validate_evaluation do
      transitions to: :validating_amount, guard: :receiver_approved?
    end

    event :validate_amount_allowed do
      transitions to: :validating_credits, guard: :has_quota?
    end

    event :validate_credits do
      transitions to: :ready, guard: :has_credits?
    end
  end

  has_paper_trail
  belongs_to :material_type, class_name: 'MaterialType', foreign_key: 'material_type_id'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :outgoing_transfers, class_name: 'Transfer', foreign_key: 'sender_material_id', dependent: :destroy
  has_many :incoming_transfers, class_name: 'Transfer', foreign_key: 'receiver_material_id', dependent: :destroy
  has_many :order_materials
  has_many :orders, through: :order_materials

  # Returns an array, the first element will be a boolean that describes
  # whether or not the tranfer was successful. If the tranfer is successful
  # it will be passed as the second element, if no the second element would
  # be the state of the Material to describe where it's stuck, with a message
  # attached to <exception>.failures to display on the front-end

  def split(receiver, amount)
    # Run validations
    validate_transfer(receiver, amount)

    # Duplicate Material being sent
    receiver_material = dup

    # Remove amount to be sent from original Material
    self.weight -= amount

    # Add amount to be sent to receiver Material
    receiver_material.weight = amount

    # Assign receiver as the owner of the new Material
    receiver_material.owner = receiver

    # Assign the same type for both Materials
    receiver_material.material_type = material_type
    receiver_material.save
    save

    if material_type.name == 'oil'
      receiver.profile.quota_left_oil -= amount
    else
      receiver.profile.quota_left_dry -= amount
    end

    # Deduct credits from receiver Profile
    receiver.profile.credits -= cost * amount
    receiver.profile.save

    # Create a new Tranfer object with all the details
    transfer = Transfer.create(sender_material: self,
                               receiver_material: receiver_material,
                               sender: owner,
                               receiver: receiver,
                               weight: amount)
    [true, transfer]
  rescue AASM::InvalidTransition, ArgumentError => e
    [false, error_message(e), e]
  end

  private

  def validate_transfer(receiver, amount)
    start_tranfer
    validate_dispensary!
    validate_stock!(amount)
    validate_receiver!(receiver)
    validate_evaluation!(receiver)
    validate_amount_allowed!(receiver, amount)
    validate_credits!(receiver, amount)
  end

  def error_message(err)
    if err.class == AASM::InvalidTransition
      case aasm.current_event
      when :validate_dispensary!
        message = I18n.t('materials.profile_locked')
      when :validate_stock!
        message = I18n.t('materials.restock')
      when :validate_receiver!
        message = I18n.t('materials.profile_invalid')
      when :validate_evaluation!
        message = I18n.t('materials.unapproved')
      when :validate_amount_allowed!
        message = I18n.t('materials.quota')
      when :validate_credits!
        message = I18n.t('materials.credits')
      else
        message = err
      end
      message
    else err.message
    end
  end

  # Validates that the sender has the correct role and that their account isn't locked
  def dispensary_locked?
    %w[admin warehouse dispensary].include?(owner.profile.role) && !owner.profile.locked
  end

  # Validates that the amount is a positive integer and that the sender has enough material to send
  def stock_enough?(amount)
    raise ArgumentError.new(
      "Amount should be a positive integer, got #{amount}"
    ) unless amount.positive?
    weight >= amount
  end

  # Validates if the receiver has filled their information, has been verified
  def receiver_valid?(receiver)
    (%w[dispensary warehouse admin participant].include? receiver.profile.role) && receiver.onboarded?
  end

  # Validates if the receiver has been evaluated by a doctor
  def receiver_approved?(receiver)
    receiver.approved?
  end

  # Validates if the receiver has not exhausted their quota for the interval
  def has_quota?(receiver, amount)
    return true if %w[dispensary warehouse admin].include? receiver.profile.role

    if MaterialType.find(self.material_type_id).name == 'Oil'
      receiver.profile.quota_left_oil >= amount
    else
      receiver.profile.quota_left_dry >= amount
    end
  end

  # Validates if the receiver has enough credits to receieve the transfer
  def has_credits?(receiver, amount)
    return true if %w[dispensary warehouse admin].include? receiver.profile.role

    receiver.profile.credits >= (amount * cost)
  end
end
