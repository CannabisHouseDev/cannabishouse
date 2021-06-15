class Order < ApplicationRecord
  belongs_to :user
  has_many :order_materials
  has_many :materials, through: :order_materials
  
  enum status: [:cart, :pending, :approved, :rejected, :done]

  validates :status, presence: true

  def material_count
    order_materials.count
  end

  def total_weight
    order_materials.sum(:amount)
  end
end
