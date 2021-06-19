require 'rails_helper'

RSpec.describe "question_options/edit", type: :view do
  before(:each) do
    @question_option = assign(:question_option, QuestionOption.create!(
      name: "MyString",
      question: nil
    ))
  end

  it "renders the edit question_option form" do
    render

    assert_select "form[action=?][method=?]", question_option_path(@question_option), "post" do

      assert_select "input[name=?]", "question_option[name]"

      assert_select "input[name=?]", "question_option[question_id]"
    end
  end
end
