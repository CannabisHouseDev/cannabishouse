require 'rails_helper'

RSpec.describe "materials/index", type: :view do
  before(:each) do
    assign(:materials, [
      Material.create!(
        material_type: nil,
        name: "Name",
        description: "Description",
        weight: 2,
        thc: "9.99",
        cbd: "9.99",
        terpene: "9.99",
        drought: false,
        oil: false,
        edible: false,
        cost: "9.99",
        owner: nil
      ),
      Material.create!(
        material_type: nil,
        name: "Name",
        description: "Description",
        weight: 2,
        thc: "9.99",
        cbd: "9.99",
        terpene: "9.99",
        drought: false,
        oil: false,
        edible: false,
        cost: "9.99",
        owner: nil
      )
    ])
  end

  it "renders a list of materials" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
