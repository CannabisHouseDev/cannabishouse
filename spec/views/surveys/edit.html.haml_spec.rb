require 'rails_helper'

RSpec.describe "surveys/edit", type: :view do
  before(:each) do
    @survey = assign(:survey, Survey.create!(
      title: "MyString",
      description: "MyString",
      user: nil
    ))
  end

  it "renders the edit survey form" do
    render

    assert_select "form[action=?][method=?]", survey_path(@survey), "post" do

      assert_select "input[name=?]", "survey[title]"

      assert_select "input[name=?]", "survey[description]"

      assert_select "input[name=?]", "survey[user_id]"
    end
  end
end
