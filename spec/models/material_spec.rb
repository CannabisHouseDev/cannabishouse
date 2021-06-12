# == Schema Information
#
# Table name: materials
#
#  id               :bigint           not null, primary key
#  aasm_state       :string
#  cbd              :integer
#  cost             :integer
#  description      :string
#  drought          :boolean          default(FALSE)
#  edible           :boolean          default(FALSE)
#  name             :string
#  oil              :boolean          default(FALSE)
#  terpene          :integer
#  thc              :integer
#  weight           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  material_type_id :bigint           not null
#  owner_id         :bigint           not null
#
# Indexes
#
#  index_materials_on_material_type_id  (material_type_id)
#  index_materials_on_owner_id          (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (material_type_id => material_types.id)
#  fk_rails_...  (owner_id => users.id)
#
require 'rails_helper'

RSpec.describe Material, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
