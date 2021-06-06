class Material < ApplicationRecord
  has_paper_trail
  belongs_to :material_type, class_name: "MaterialType", foreign_key: 'material_type_id'
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'

  def split(reciever, amount)
    reciever_material = self.dup
    self.weight -= amount
    reciever_material.weight = amount
    reciever_material.owner = reciever
    reciever_material.material_type = self.material_type
    reciever_material.save
    self.save
    Transfer.create(sender_material: self,
                    reciever_material: reciever_material,
                    sender: self.owner,
                    reciever: reciever,
                    weight: amount)
  end
end
