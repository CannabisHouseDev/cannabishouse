require 'rails_helper'

RSpec.describe "question_options/index", type: :view do
  before(:each) do
    assign(:question_options, [
      QuestionOption.create!(
        name: "Name",
        question: nil
      ),
      QuestionOption.create!(
        name: "Name",
        question: nil
      )
    ])
  end

  it "renders a list of question_options" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
