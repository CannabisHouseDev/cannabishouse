# == Schema Information
#
# Table name: order_materials
#
#  id          :bigint           not null, primary key
#  amount      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  material_id :bigint           not null
#  order_id    :bigint           not null
#
# Indexes
#
#  index_order_materials_on_material_id  (material_id)
#  index_order_materials_on_order_id     (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (material_id => materials.id)
#  fk_rails_...  (order_id => orders.id)
#
class OrderMaterial < ApplicationRecord
  belongs_to :order
  belongs_to :material

  validates :amount, presence: true
end
