class MaterialType < ApplicationRecord
  has_many :materials , class_name: 'Material', foreign_key: 'material_type_id'
end
