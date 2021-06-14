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
    error_on_all_events :handle_error_for_all_events
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

    event :process_tranfer, before: :reset, after: :validate_dispensary do
      transitions to: :validating_dispensary
    end

    event :validate_dispensary, after: :validate_stock do
      transitions to: :validating_stock, guard: :dispensary_locked?
    end

    event :validate_stock, after: :validate_receiver do
      transitions to: :validating_profile, guard: :stock_enough?
    end

    event :validate_receiver, after: :validate_evaluation do
      transitions to: :validating_evaluation, guard: :receiver_valid?
    end

    event :validate_evaluation, after: :validate_amount_allowed do
      transitions to: :validating_amount, guard: :receiver_approved?
    end

    event :validate_amount_allowed, after: :validate_credits do
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

  # Returns an array, the first element will be a boolean that describes
  # whether or not the tranfer was successful. If the tranfer is successful
  # it will be passed as the second element, if no the second element would
  # be the state of the Material to describe where it's stuck, with a message
  # attached to <exception>.failures to display on the front-end

  def split(receiver, amount)
    # Run validations
    process_tranfer!(receiver, amount)

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
  rescue AASM::InvalidTransition => e
    [false, e]
  end

  private

  def handle_error_for_all_events(err)
    byebug
    case aasm.current_event
    when :validate_dispensary
      message = t('materials.profile_locked')
    when :validate_stock
      message = t('materials.restock')
    when :validate_receiver
      message = t('materials.profile_invalid')
    when :validate_evaluation
      message = t('materials.unapproved')
    when :validate_amount_allowed
      message = t('materials.quota')
    when :validate_credits
      message = t('materials.credits')
    else
      message = t('materials.unknown_error')
    end
    err.failures.replace [message]
    raise err and return
  end

  # Validates that the sender has the correct role and that their account isn't locked
  def dispensary_locked?
    profile = owner.profile
    %w[admin warehouse dispensary].include?(profile.role) && !profile.locked
  end

  # Validates that the amount is a positive integer and that the sender has enough material to send
  def stock_enough?(receiver, amount)
    (self.weight >= amount) && amount.positive?
  end

  # Validates if the receiver has filled their information, has been verified
  def receiver_valid?(receiver)
    (%w[dispensary warehouse admin participant].include? receiver.profile.role) && receiver.onboarded? && receiver.verified?
  end

  # Validates if the receiver has been evaluated by a doctor
  def receiver_approved?(receiver)
    receiver.approved?
  end

  # Validates if the receiver has not exhausted their quota for the interval
  def has_quota?(receiver, amount)
    return true if %w[dispensary warehouse admin].include? receiver.profile.role
    receiver.profile.quota_left >= amount
  end

  # Validates if the receiver has enough credits to receieve the transfer
  def has_credits?(receiver, amount)
    return true if %w[dispensary warehouse admin].include? receiver.profile.role
    credits_needed = amount * cost
    receiver.profile.credits >= credits_needed
  end
end
