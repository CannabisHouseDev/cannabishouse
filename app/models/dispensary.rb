# == Schema Information
#
# Table name: dispensaries
#
#  id          :bigint           not null, primary key
#  avatar      :string
#  category    :integer
#  description :string
#  documents   :string
#  lat         :decimal(, )
#  lng         :decimal(, )
#  name        :string
#  open        :boolean
#  verified    :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  manager_id  :bigint           not null
#
# Indexes
#
#  index_dispensaries_on_manager_id  (manager_id)
#
# Foreign Keys
#
#  fk_rails_...  (manager_id => users.id)
#
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
