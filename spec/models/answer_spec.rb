# == Schema Information
#
# Table name: answers
#
#  id               :bigint           not null, primary key
#  content          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  filled_survey_id :bigint           not null
#  option_id        :integer
#  question_id      :bigint           not null
#
# Indexes
#
#  index_answers_on_filled_survey_id  (filled_survey_id)
#  index_answers_on_question_id       (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (filled_survey_id => filled_surveys.id)
#  fk_rails_...  (question_id => questions.id)
#
require 'rails_helper'

RSpec.describe Answer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
