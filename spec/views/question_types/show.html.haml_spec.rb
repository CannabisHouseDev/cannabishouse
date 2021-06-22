require 'rails_helper'

RSpec.describe "question_types/show", type: :view do
  before(:each) do
    @question_type = assign(:question_type, QuestionType.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
