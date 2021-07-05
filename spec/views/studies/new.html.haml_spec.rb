require 'rails_helper'

RSpec.describe "studies/new", type: :view do
  before(:each) do
    assign(:study, Study.new(
      title: "MyString",
      description: "MyString",
      user: nil,
      max: 1,
      fee: 1,
      cycle: 1
    ))
  end

  it "renders new study form" do
    render

    assert_select "form[action=?][method=?]", studies_path, "post" do

      assert_select "input[name=?]", "study[title]"

      assert_select "input[name=?]", "study[description]"

      assert_select "input[name=?]", "study[user_id]"

      assert_select "input[name=?]", "study[max]"

      assert_select "input[name=?]", "study[fee]"

      assert_select "input[name=?]", "study[cycle]"
    end
  end
end
