require 'rails_helper'

RSpec.describe "question_options/new", type: :view do
  before(:each) do
    assign(:question_option, QuestionOption.new(
      name: "MyString",
      question: nil
    ))
  end

  it "renders new question_option form" do
    render

    assert_select "form[action=?][method=?]", question_options_path, "post" do

      assert_select "input[name=?]", "question_option[name]"

      assert_select "input[name=?]", "question_option[question_id]"
    end
  end
end
