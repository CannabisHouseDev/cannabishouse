require 'rails_helper'

RSpec.describe "answers/new", type: :view do
  before(:each) do
    assign(:answer, Answer.new(
      filled_survey: nil,
      content: "MyString"
    ))
  end

  it "renders new answer form" do
    render

    assert_select "form[action=?][method=?]", answers_path, "post" do

      assert_select "input[name=?]", "answer[filled_survey_id]"

      assert_select "input[name=?]", "answer[content]"
    end
  end
end
