class Dispensary < ApplicationRecord
  has_paper_trail
  has_one_attached :avatar
  has_many_attached :documents
  belongs_to :manager, class_name: 'User', foreign_key: 'manager_id'

  has_one :address, as: :addressable

  enum category: %i[ basic gastro pro ], _default: 0
  validates :name, :category, presence: true

  has_rich_text :description
end
