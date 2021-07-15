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
require 'rails_helper'

RSpec.describe AppointmentSlot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
