require 'rails_helper'

RSpec.describe "studies/show", type: :view do
  before(:each) do
    @study = assign(:study, Study.create!(
      title: "Title",
      description: "Description",
      user: nil,
      max: 2,
      fee: 3,
      cycle: 4
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
  end
end
