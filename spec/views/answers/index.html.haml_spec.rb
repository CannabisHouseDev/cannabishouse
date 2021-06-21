require 'rails_helper'

RSpec.describe "answers/index", type: :view do
  before(:each) do
    assign(:answers, [
      Answer.create!(
        filled_survey: nil,
        content: "Content"
      ),
      Answer.create!(
        filled_survey: nil,
        content: "Content"
      )
    ])
  end

  it "renders a list of answers" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Content".to_s, count: 2
  end
end
