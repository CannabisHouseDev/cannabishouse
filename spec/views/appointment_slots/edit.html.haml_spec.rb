require 'rails_helper'

RSpec.describe "appointment_slots/edit", type: :view do
  before(:each) do
    @appointment_slot = assign(:appointment_slot, AppointmentSlot.create!(
      slot: nil
    ))
  end

  it "renders the edit appointment_slot form" do
    render

    assert_select "form[action=?][method=?]", appointment_slot_path(@appointment_slot), "post" do

      assert_select "input[name=?]", "appointment_slot[slot_id]"
    end
  end
end
