require 'rails_helper'

RSpec.describe "question_types/new", type: :view do
  before(:each) do
    assign(:question_type, QuestionType.new(
      name: "MyString"
    ))
  end

  it "renders new question_type form" do
    render

    assert_select "form[action=?][method=?]", question_types_path, "post" do

      assert_select "input[name=?]", "question_type[name]"
    end
  end
end
