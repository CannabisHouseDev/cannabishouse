# == Schema Information
#
# Table name: studies
#
#  id          :bigint           not null, primary key
#  cycle       :integer
#  description :string
#  fee         :integer
#  max         :integer
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_studies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Study, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
