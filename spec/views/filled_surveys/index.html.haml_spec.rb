require 'rails_helper'

RSpec.describe "filled_surveys/index", type: :view do
  before(:each) do
    assign(:filled_surveys, [
      FilledSurvey.create!(
        survey: nil,
        state: "State",
        user: nil
      ),
      FilledSurvey.create!(
        survey: nil,
        state: "State",
        user: nil
      )
    ])
  end

  it "renders a list of filled_surveys" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "State".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
