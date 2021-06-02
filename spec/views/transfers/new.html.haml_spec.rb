require 'rails_helper'

RSpec.describe "transfers/new", type: :view do
  before(:each) do
    assign(:transfer, Transfer.new(
      sender_material: nil,
      reciever_material: nil,
      sender: nil,
      reciever: nil,
      weight: 1
    ))
  end

  it "renders new transfer form" do
    render

    assert_select "form[action=?][method=?]", transfers_path, "post" do

      assert_select "input[name=?]", "transfer[sender_material_id]"

      assert_select "input[name=?]", "transfer[reciever_material_id]"

      assert_select "input[name=?]", "transfer[sender_id]"

      assert_select "input[name=?]", "transfer[reciever_id]"

      assert_select "input[name=?]", "transfer[weight]"
    end
  end
end
