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
