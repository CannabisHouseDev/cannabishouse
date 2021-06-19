class QuestionOptionSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :question
end
