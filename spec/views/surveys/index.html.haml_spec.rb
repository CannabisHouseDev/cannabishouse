require 'rails_helper'

RSpec.describe "surveys/index", type: :view do
  before(:each) do
    assign(:surveys, [
      Survey.create!(
        title: "Title",
        description: "Description",
        user: nil
      ),
      Survey.create!(
        title: "Title",
        description: "Description",
        user: nil
      )
    ])
  end

  it "renders a list of surveys" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
