# == Schema Information
#
# Table name: surveys
#
#  id          :bigint           not null, primary key
#  description :string
#  hidden      :boolean          default(FALSE)
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_surveys_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Survey < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  has_many :questions, class_name: 'Question', dependent: :destroy
  accepts_nested_attributes_for :questions

  def hide
    self.hidden = true
    save
  end
end
