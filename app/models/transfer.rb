class Transfer < ApplicationRecord
  has_paper_trail
  belongs_to :sender_material, class_name: "Material", foreign_key: 'sender_material_id', dependent: :destroy
  belongs_to :reciever_material, class_name: "Material", foreign_key: 'reciever_material_id', dependent: :destroy
  belongs_to :sender, class_name: "User", foreign_key: 'sender_id', dependent: :destroy
  belongs_to :reciever, class_name: "User", foreign_key: 'reciever_id', dependent: :destroy
end
