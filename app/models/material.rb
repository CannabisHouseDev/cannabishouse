class Material < ApplicationRecord
  belongs_to :material_type
  belongs_to :owner
end
