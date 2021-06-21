# == Schema Information
#
# Table name: answers
#
#  id               :bigint           not null, primary key
#  content          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  filled_survey_id :bigint           not null
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
class Answer < ApplicationRecord
  belongs_to :filled_survey
  belongs_to :question

  validates :content, presence: true, length: { minimum: 1 }, on: :update
  validate :content, :validate_question_rules, on: :update

  def validate_question_rules
    content.to_i.between?(question.min, question.max) if question.question_type.name == 'number'
    true
  end
end
