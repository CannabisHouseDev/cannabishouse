require 'rails_helper'

RSpec.describe "answers/edit", type: :view do
  before(:each) do
    @answer = assign(:answer, Answer.create!(
      filled_survey: nil,
      content: "MyString"
    ))
  end

  it "renders the edit answer form" do
    render

    assert_select "form[action=?][method=?]", answer_path(@answer), "post" do

      assert_select "input[name=?]", "answer[filled_survey_id]"

      assert_select "input[name=?]", "answer[content]"
    end
  end
end
