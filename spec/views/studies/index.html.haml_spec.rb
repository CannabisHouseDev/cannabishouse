require 'rails_helper'

RSpec.describe "studies/index", type: :view do
  before(:each) do
    assign(:studies, [
      Study.create!(
        title: "Title",
        description: "Description",
        user: nil,
        max: 2,
        fee: 3,
        cycle: 4
      ),
      Study.create!(
        title: "Title",
        description: "Description",
        user: nil,
        max: 2,
        fee: 3,
        cycle: 4
      )
    ])
  end

  it "renders a list of studies" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
  end
end
