# == Schema Information
#
# Table name: material_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class MaterialType < ApplicationRecord
  has_paper_trail
  has_many :materials , class_name: 'Material', foreign_key: 'material_type_id', dependent: :destroy
end
