# == Schema Information
#
# Table name: slots
#
#  id         :bigint           not null, primary key
#  booked     :boolean          default(FALSE)
#  day        :integer          default(1)
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_slots_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Slot < ApplicationRecord
  belongs_to :doctor, class_name: 'User', foreign_key: 'user_id'

  VALID_TIME_FORMAT = /\d{1,2}:\d{1,2}/
  validates :time, format: { with: VALID_TIME_FORMAT }
  validates :day, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }

  def hours
    time.split(':').first
  end

  def minutes
    time.split(':').last
  end
end
