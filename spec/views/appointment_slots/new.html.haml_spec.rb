require 'rails_helper'

RSpec.describe "appointment_slots/new", type: :view do
  before(:each) do
    assign(:appointment_slot, AppointmentSlot.new(
      slot: nil
    ))
  end

  it "renders new appointment_slot form" do
    render

    assert_select "form[action=?][method=?]", appointment_slots_path, "post" do

      assert_select "input[name=?]", "appointment_slot[slot_id]"
    end
  end
end
