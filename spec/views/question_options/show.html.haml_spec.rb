require 'rails_helper'

RSpec.describe "question_options/show", type: :view do
  before(:each) do
    @question_option = assign(:question_option, QuestionOption.create!(
      name: "Name",
      question: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
