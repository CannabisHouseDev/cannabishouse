# == Schema Information
#
# Table name: appointments
#
#  id             :bigint           not null, primary key
#  state          :integer
#  time           :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  doctor_id      :bigint           not null
#  participant_id :bigint           not null
#
# Indexes
#
#  index_appointments_on_doctor_id       (doctor_id)
#  index_appointments_on_participant_id  (participant_id)
#
require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
