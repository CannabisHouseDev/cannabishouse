class OrderMaterial < ApplicationRecord
  belongs_to :order
  belongs_to :material

  validates :amount, presence: true
end
