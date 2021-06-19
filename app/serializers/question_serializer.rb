class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :min, :max, :placeholder
  has_one :question_type
  has_one :survey
end
