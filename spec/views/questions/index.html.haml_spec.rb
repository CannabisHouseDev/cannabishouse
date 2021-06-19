require 'rails_helper'

RSpec.describe "questions/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        title: "Title",
        description: "Description",
        question_type: nil,
        survey: nil,
        min: 2,
        max: 3,
        placeholder: "Placeholder"
      ),
      Question.create!(
        title: "Title",
        description: "Description",
        question_type: nil,
        survey: nil,
        min: 2,
        max: 3,
        placeholder: "Placeholder"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "Placeholder".to_s, count: 2
  end
end
