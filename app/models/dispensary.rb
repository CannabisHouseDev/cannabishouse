class Dispensary < ApplicationRecord
  has_one_attached :avatar
  has_many_attached :documents

  has_one :address, as: :addressable

  enum category: %i[ basic gastro pro ], _default: 0
  validates :name, :category, presence: true

  has_rich_text :description
end
