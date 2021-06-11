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
end
