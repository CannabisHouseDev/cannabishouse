require 'rails_helper'

RSpec.describe "filled_surveys/show", type: :view do
  before(:each) do
    @filled_survey = assign(:filled_survey, FilledSurvey.create!(
      survey: nil,
      state: "State",
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/State/)
    expect(rendered).to match(//)
  end
end
