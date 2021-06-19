require 'rails_helper'

RSpec.describe "questions/new", type: :view do
  before(:each) do
    assign(:question, Question.new(
      title: "MyString",
      description: "MyString",
      question_type: nil,
      survey: nil,
      min: 1,
      max: 1,
      placeholder: "MyString"
    ))
  end

  it "renders new question form" do
    render

    assert_select "form[action=?][method=?]", questions_path, "post" do

      assert_select "input[name=?]", "question[title]"

      assert_select "input[name=?]", "question[description]"

      assert_select "input[name=?]", "question[question_type_id]"

      assert_select "input[name=?]", "question[survey_id]"

      assert_select "input[name=?]", "question[min]"

      assert_select "input[name=?]", "question[max]"

      assert_select "input[name=?]", "question[placeholder]"
    end
  end
end
