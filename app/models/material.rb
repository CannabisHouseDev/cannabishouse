# == Schema Information
#
# Table name: materials
#
#  id               :bigint           not null, primary key
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
  inlcude AASM
  has_paper_trail
  belongs_to :material_type, class_name: "MaterialType", foreign_key: 'material_type_id'
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id', dependent: :destroy

  def split(receiver, amount)
    receiver_material = self.dup
    self.weight -= amount
    receiver_material.weight = amount
    receiver_material.owner = receiver
    receiver_material.material_type = self.material_type
    receiver_material.save
    self.save
    transfer = Transfer.create(sender_material: self,
                    receiver_material: receiver_material,
                    sender: self.owner,
                    receiver: receiver,
                    weight: amount)
    transfer
  end

  aasm do
    state :ready, initial: true
          :validating_dispensary
          :validating_stock
          :validating_profile
          :validating_evaluation
          :validating_amount
          :validating_credits
          :validating_duplicate

    event :process do
      transitions from: :ready, to: :validating_dispensary
    end

    event :validate_dispensary do
      transitions from: :validating_dispensary, to: :validating_stock
    end

    event :validate_stock do
      transitions from: :validating_stock, to: :validating_profile
    end

    event :validate_profile do
      transitions from: :validating_profile, to: :validating_evaluation
    end

    event :validate_evaluation do
      transitions from: :validating_evaluation, to: :validating_amount
    end

    event :validate_amount do
      transitions from: :validating_amount, to: :validating_credits
    end

    event :validate_credits do
      transitions from: :validating_credits, to: :validating_duplicate
    end

    event :finalize do
      transitions from: :validating_duplicate, to: :ready
    end

  end
end
