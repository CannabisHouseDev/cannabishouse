# == Schema Information
#
# Table name: question_options
#
#  id          :bigint           not null, primary key
#  display     :string
#  name        :string
#  score       :integer          default(0)
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
class QuestionOption < ApplicationRecord
  belongs_to :question, optional: true
end
