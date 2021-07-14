# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  status     :integer          default("requested"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_materials
  has_many :materials, through: :order_materials
  
  enum status: [:requested, :approved, :rejected, :dispatched, :done]

  validates :status, presence: true

  def material_count
    order_materials.count
  end

  def total_weight
    order_materials.sum(:amount)
  end
end
