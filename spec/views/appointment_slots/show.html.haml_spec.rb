require 'rails_helper'

RSpec.describe "appointment_slots/show", type: :view do
  before(:each) do
    @appointment_slot = assign(:appointment_slot, AppointmentSlot.create!(
      slot: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
