# == Schema Information
#
# Table name: appointment_slots
#
#  id         :bigint           not null, primary key
#  booked     :boolean          default(FALSE)
#  time       :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slot_id    :bigint           not null
#
# Indexes
#
#  index_appointment_slots_on_slot_id  (slot_id)
#
# Foreign Keys
#
#  fk_rails_...  (slot_id => slots.id)
#
class AppointmentSlotSerializer < ActiveModel::Serializer
  attributes :id, :time
  has_one :slot
end
