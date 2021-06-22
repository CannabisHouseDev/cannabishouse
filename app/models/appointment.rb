# == Schema Information
#
# Table name: appointments
#
#  id         :bigint           not null, primary key
#  date       :date             not null
#  state      :integer          default("pending"), not null
#  time       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Appointment < ApplicationRecord
  has_one :slot

  belongs_to :participant, class_name: 'User'
  belongs_to :doctor, class_name: 'User'
  belongs_to :slot


  enum state: [:pending, :done, :cancelled]

  validates :time, presence: true

  def time
    datetime = self.time << dt
    datetime.update # Or should be here datetime.save ?
  end

  private

  def set_time
    dt = DateTime(d.year, d.month, d.day, h, m)
  end

  def h
    Slot.time.strftime('%H').to_i
  end

  def m
    Slot.time.strftime('%M').to_i
  end

  def d
    self.date
  end
end
