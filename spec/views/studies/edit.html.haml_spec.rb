require 'rails_helper'

RSpec.describe "studies/edit", type: :view do
  before(:each) do
    @study = assign(:study, Study.create!(
      title: "MyString",
      description: "MyString",
      user: nil,
      max: 1,
      fee: 1,
      cycle: 1
    ))
  end

  it "renders the edit study form" do
    render

    assert_select "form[action=?][method=?]", study_path(@study), "post" do

      assert_select "input[name=?]", "study[title]"

      assert_select "input[name=?]", "study[description]"

      assert_select "input[name=?]", "study[user_id]"

      assert_select "input[name=?]", "study[max]"

      assert_select "input[name=?]", "study[fee]"

      assert_select "input[name=?]", "study[cycle]"
    end
  end
end
