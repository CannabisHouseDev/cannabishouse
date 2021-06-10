class Order < ApplicationRecord
  belongs_to :user
  has_many :order_materials
  has_many :materials, through: :order_materials
  
  enum status: [:pending, :approved, :rejected, :done]

  validates :status, presence: true
  validates :amount, numericality: { maximum: 5 }, presence: true
end