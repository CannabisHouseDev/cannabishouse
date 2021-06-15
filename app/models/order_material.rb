class OrderMaterial < ApplicationRecord
  belongs_to :order
  belongs_to :material

  validates :amount, numericality: { maximum: 5 }, presence: true
end
