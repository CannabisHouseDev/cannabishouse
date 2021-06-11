# == Schema Information
#
# Table name: transfers
#
#  id                   :bigint           not null, primary key
#  weight               :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  receiver_id          :bigint           not null
#  receiver_material_id :bigint           not null
#  sender_id            :bigint           not null
#  sender_material_id   :bigint           not null
#
# Indexes
#
#  index_transfers_on_receiver_id           (receiver_id)
#  index_transfers_on_receiver_material_id  (receiver_material_id)
#  index_transfers_on_sender_id             (sender_id)
#  index_transfers_on_sender_material_id    (sender_material_id)
#
# Foreign Keys
#
#  fk_rails_...  (receiver_id => users.id)
#  fk_rails_...  (receiver_material_id => materials.id)
#  fk_rails_...  (sender_id => users.id)
#  fk_rails_...  (sender_material_id => materials.id)
#
class Transfer < ApplicationRecord
  has_paper_trail
  belongs_to :sender_material, class_name: "Material", foreign_key: 'sender_material_id', dependent: :destroy
  belongs_to :receiver_material, class_name: "Material", foreign_key: 'receiver_material_id', dependent: :destroy
  belongs_to :sender, class_name: "User", foreign_key: 'sender_id', dependent: :destroy
  belongs_to :receiver, class_name: "User", foreign_key: 'receiver_id', dependent: :destroy
end
