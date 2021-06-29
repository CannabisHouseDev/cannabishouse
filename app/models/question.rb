# == Schema Information
#
# Table name: questions
#
#  id               :bigint           not null, primary key
#  description      :string
#  max              :integer
#  min              :integer
#  order            :integer          default(0)
#  placeholder      :string
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  question_type_id :bigint           not null
#  survey_id        :bigint           not null
#
# Indexes
#
#  index_questions_on_question_type_id  (question_type_id)
#  index_questions_on_survey_id         (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_type_id => question_types.id)
#  fk_rails_...  (survey_id => surveys.id)
#
class Question < ApplicationRecord
  belongs_to :question_type
  belongs_to :survey
  has_many :options, class_name: 'QuestionOption', dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: proc { |att| att['name'].blank? }
end
