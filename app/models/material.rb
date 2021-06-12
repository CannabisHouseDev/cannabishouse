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
  #

  aasm no_direct_assignment: true do
    state :ready, initial: true
    state :validating_dispensary
    state :validating_stock
    state :validating_profile
    state :validating_evaluation
    state :validating_amount
    state :validating_credits
    state :validating_duplicate

    event :reset do
      transitions to: :ready
    end

    event :start_validation do
      transitions from: :ready, to: :validating_dispensary
    end

    event :validate_dispensary do
      transitions from: :validating_dispensary, to: :validating_stock, guard: :dispensary_locked?
    end

    event :validate_stock do
      transitions from: :validating_stock, to: :validating_profile, guard: :stock_enough?
    end

    event :validate_receiver do
      transitions from: :validating_profile, to: :validating_evaluation, guard: :receiver_valid?
    end

    event :validate_evaluation do
      transitions from: :validating_evaluation, to: :validating_amount, guard: :receiver_approved?
    end

    event :validate_amount_allowed do
      transitions from: :validating_amount, to: :validating_credits, guard: :has_quota?
    end

    event :validate_credits do
      transitions from: :validating_credits, to: :ready, guard: :has_credits?
    end
  end

  has_paper_trail
  belongs_to :material_type, class_name: "MaterialType", foreign_key: 'material_type_id'
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'
  has_many :transfers, class_name: "Transfer", foreign_key: 'sender_material_id', dependent: :destroy
  has_many :transfers, class_name: "Transfer", foreign_key: 'receiver_material_id', dependent: :destroy


  # Returns an array, the first element will be a boolean that describes
  # whether or not the tranfer was successful. If the tranfer is successful
  # it will be passed as the second element, if no the second element would
  # be the state of the Material to describe where it's stuck
  def split(receiver, amount)

    # Run validations
    process(receiver, amount)

    # Process tranfer if all states transitioned
    if self.aasm_state == 'ready'

      # Duplicate Material being sent
      receiver_material = self.dup

      # Remove amount to be sent from original Material
      self.weight -= amount

      # Add amount to be sent to receiver Material
      receiver_material.weight = amount

      # Assign receiver as the owner of the new Material
      receiver_material.owner = receiver

      # Assign the same type for both Materials
      receiver_material.material_type = self.material_type
      receiver_material.save
      self.save

      # Deduct credits from receiver Profile
      receiver.profile.credits -= self.cost * amount
      receiver.profile.save

      # Create a new Tranfer object with all the details
      transfer = Transfer.create(sender_material: self,
                                 receiver_material: receiver_material,
                                 sender: self.owner,
                                 receiver: receiver,
                                 weight: amount)
      return [true, transfer]
    else
      return [false, self.aasm_state]
    end
  end

  private

  def process(receiver, amount)
    start_validation
    validate_dispensary
    validate_stock(amount)
    validate_receiver(receiver)
    validate_evaluation(receiver)
    validate_amount_allowed(receiver, amount)
    validate_credits(receiver, amount)
  end

  # Validates that the sender has the correct role and that their account isn't locked
  def dispensary_locked?
    profile = owner.profile
    %w[admin warehouse dispensary].include?(profile.role) && !profile.locked
  end

  # Validates that the amount is a positive integer and that the sender has enough material to send
  def stock_enough?(amount)
    (self.weight >= amount) && (amount > 0)
  end

  # Validates if the receiver has filled their information, has been verified
  def receiver_valid?(receiver)
    receiver.onboarded? && receiver.verified?
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
    credits_needed = amount * self.cost
    receiver.profile.credits >= credits_needed
  end
end
