# == Schema Information
#
# Table name: questions
#
#  id               :bigint           not null, primary key
#  description      :string
#  max              :integer
#  min              :integer
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
class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :min, :max, :placeholder
  has_one :question_type
  has_one :survey
end
