require 'rails_helper'

RSpec.describe "transfers/index", type: :view do
  before(:each) do
    assign(:transfers, [
      Transfer.create!(
        sender_material: nil,
        receiver_material: nil,
        sender: nil,
        receiver: nil,
        weight: 2
      ),
      Transfer.create!(
        sender_material: nil,
        receiver_material: nil,
        sender: nil,
        receiver: nil,
        weight: 2
      )
    ])
  end

  it "renders a list of transfers" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
