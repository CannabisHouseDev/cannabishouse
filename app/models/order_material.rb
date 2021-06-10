class OrderMaterial < ApplicationRecord
  belongs_to :order
  belongs_to :material
end
