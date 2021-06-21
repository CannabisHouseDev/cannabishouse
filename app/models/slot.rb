class Slot < ApplicationRecord
  belongs_to :doctor, class_name: 'User'
  has_many :appointments

  VALID_TIME_FORMAT= /^\d{1,2}:\d{1,2}$/
  validates :time, format:{with:VALID_TIME_FORMAT}
  validates :day, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 6 }

end
