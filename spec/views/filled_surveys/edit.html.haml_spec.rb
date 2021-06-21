require 'rails_helper'

RSpec.describe "filled_surveys/edit", type: :view do
  before(:each) do
    @filled_survey = assign(:filled_survey, FilledSurvey.create!(
      survey: nil,
      state: "MyString",
      user: nil
    ))
  end

  it "renders the edit filled_survey form" do
    render

    assert_select "form[action=?][method=?]", filled_survey_path(@filled_survey), "post" do

      assert_select "input[name=?]", "filled_survey[survey_id]"

      assert_select "input[name=?]", "filled_survey[state]"

      assert_select "input[name=?]", "filled_survey[user_id]"
    end
  end
end
