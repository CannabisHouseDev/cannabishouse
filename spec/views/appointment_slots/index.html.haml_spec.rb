require 'rails_helper'

RSpec.describe "appointment_slots/index", type: :view do
  before(:each) do
    assign(:appointment_slots, [
      AppointmentSlot.create!(
        slot: nil
      ),
      AppointmentSlot.create!(
        slot: nil
      )
    ])
  end

  it "renders a list of appointment_slots" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
