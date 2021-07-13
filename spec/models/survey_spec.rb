# == Schema Information
#
# Table name: surveys
#
#  id            :bigint           not null, primary key
#  description   :string
#  hidden        :boolean          default(FALSE)
#  internal_name :string
#  required      :boolean          default(FALSE)
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  study_id      :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_surveys_on_study_id  (study_id)
#  index_surveys_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (study_id => studies.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Survey, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
