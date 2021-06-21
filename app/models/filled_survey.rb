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
class FilledSurvey < ApplicationRecord
  belongs_to :survey
  belongs_to :participant, class_name: 'User'
  has_many :answers, class_name: 'Answer'
  accepts_nested_attributes_for :answers
  validates :state, inclusion: { in: %w[pending done redo] }
end
