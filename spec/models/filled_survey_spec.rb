# == Schema Information
#
# Table name: filled_surveys
#
#  id         :bigint           not null, primary key
#  state      :string           default("pending")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_filled_surveys_on_survey_id  (survey_id)
#  index_filled_surveys_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe FilledSurvey, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
