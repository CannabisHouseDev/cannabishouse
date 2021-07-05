# == Schema Information
#
# Table name: surveys
#
#  id            :bigint           not null, primary key
#  description   :string
#  hidden        :boolean          default(FALSE)
#  internal_name :string
#  required      :boolean          default(FALSE)
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  study_id      :bigint           default(1), not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_surveys_on_study_id  (study_id)
#  index_surveys_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (study_id => studies.id)
#  fk_rails_...  (user_id => users.id)
#
class Survey < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :study
  has_many :questions, class_name: 'Question', dependent: :destroy
  has_many :filled, class_name: 'FilledSurvey'
  belongs_to :study
  accepts_nested_attributes_for :questions

  def hide
    self.hidden = true
    save
  end
end
