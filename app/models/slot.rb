# == Schema Information
#
# Table name: slots
#
#  id         :bigint           not null, primary key
#  booked     :boolean          default(FALSE)
#  day        :integer          default(1)
#  time       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Slot < ApplicationRecord
  belongs_to :doctor, class_name: 'User'

  VALID_TIME_FORMAT=  /\A([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]\z/
  validates :time, format: { with: VALID_TIME_FORMAT }
  validates :day, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }

  def hours
    time.split(':').first
  end

  def minutes
    time.split(':').last
  end
end
