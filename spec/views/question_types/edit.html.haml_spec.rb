require 'rails_helper'

RSpec.describe "question_types/edit", type: :view do
  before(:each) do
    @question_type = assign(:question_type, QuestionType.create!(
      name: "MyString"
    ))
  end

  it "renders the edit question_type form" do
    render

    assert_select "form[action=?][method=?]", question_type_path(@question_type), "post" do

      assert_select "input[name=?]", "question_type[name]"
    end
  end
end
