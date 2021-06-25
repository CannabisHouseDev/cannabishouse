# == Schema Information
#
# Table name: question_options
#
#  id          :bigint           not null, primary key
#  display     :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :bigint           not null
#
# Indexes
#
#  index_question_options_on_question_id  (question_id)
#
# Foreign Keys
#
#  fk_rails_...  (question_id => questions.id)
#
class QuestionOptionSerializer < ActiveModel::Serializers
  attributes :id, :name
  has_one :question
end
