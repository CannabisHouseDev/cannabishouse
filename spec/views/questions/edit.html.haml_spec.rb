require 'rails_helper'

RSpec.describe "questions/edit", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      title: "MyString",
      description: "MyString",
      question_type: nil,
      survey: nil,
      min: 1,
      max: 1,
      placeholder: "MyString"
    ))
  end

  it "renders the edit question form" do
    render

    assert_select "form[action=?][method=?]", question_path(@question), "post" do

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
