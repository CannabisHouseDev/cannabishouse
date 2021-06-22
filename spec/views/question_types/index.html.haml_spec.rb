require 'rails_helper'

RSpec.describe "question_types/index", type: :view do
  before(:each) do
    assign(:question_types, [
      QuestionType.create!(
        name: "Name"
      ),
      QuestionType.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of question_types" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
