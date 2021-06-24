require 'rails_helper'

RSpec.describe "transfers/new", type: :view do
  before(:each) do
    assign(:transfer, Transfer.new(
      sender_material: nil,
      receiver_material: nil,
      sender: nil,
      receiver: nil,
      weight: 1
    ))
  end

  it "renders new transfer form" do
    render

    assert_select "form[action=?][method=?]", transfers_path, "post" do

      assert_select "input[name=?]", "transfer[sender_material_id]"

      assert_select "input[name=?]", "transfer[receiver_material_id]"

      assert_select "input[name=?]", "transfer[sender_id]"

      assert_select "input[name=?]", "transfer[receiver_id]"

      assert_select "input[name=?]", "transfer[weight]"
    end
  end
end
