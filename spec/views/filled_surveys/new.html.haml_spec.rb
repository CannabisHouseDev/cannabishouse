require 'rails_helper'

RSpec.describe "filled_surveys/new", type: :view do
  before(:each) do
    assign(:filled_survey, FilledSurvey.new(
      survey: nil,
      state: "MyString",
      user: nil
    ))
  end

  it "renders new filled_survey form" do
    render

    assert_select "form[action=?][method=?]", filled_surveys_path, "post" do

      assert_select "input[name=?]", "filled_survey[survey_id]"

      assert_select "input[name=?]", "filled_survey[state]"

      assert_select "input[name=?]", "filled_survey[user_id]"
    end
  end
end
