class Slot < ApplicationRecord
  belongs_to :doctor, class_name: 'User'
  has_many :appointments

  VALID_TIME_FORMAT= /(?:[01]\d|2[0123]):(?:[012345]\d):(?:[012345]\d)/
  validates :time, format:{with:VALID_TIME_FORMAT}

end
