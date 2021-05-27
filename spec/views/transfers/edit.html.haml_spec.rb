require 'rails_helper'

RSpec.describe "transfers/edit", type: :view do
  before(:each) do
    @transfer = assign(:transfer, Transfer.create!(
      sender_material: nil,
      reciever_material: nil,
      sender: nil,
      reciever: nil,
      weight: 1
    ))
  end

  it "renders the edit transfer form" do
    render

    assert_select "form[action=?][method=?]", transfer_path(@transfer), "post" do

      assert_select "input[name=?]", "transfer[sender_material_id]"

      assert_select "input[name=?]", "transfer[reciever_material_id]"

      assert_select "input[name=?]", "transfer[sender_id]"

      assert_select "input[name=?]", "transfer[reciever_id]"

      assert_select "input[name=?]", "transfer[weight]"
    end
  end
end
