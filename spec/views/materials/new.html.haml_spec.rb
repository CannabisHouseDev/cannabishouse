require 'rails_helper'

RSpec.describe "materials/new", type: :view do
  before(:each) do
    assign(:material, Material.new(
      material_type: nil,
      name: "MyString",
      description: "MyString",
      weight: 1,
      thc: "9.99",
      cbd: "9.99",
      terpene: "9.99",
      drought: false,
      oil: false,
      edible: false,
      cost: "9.99",
      owner: nil
    ))
  end

  it "renders new material form" do
    render

    assert_select "form[action=?][method=?]", materials_path, "post" do

      assert_select "input[name=?]", "material[material_type_id]"

      assert_select "input[name=?]", "material[name]"

      assert_select "input[name=?]", "material[description]"

      assert_select "input[name=?]", "material[weight]"

      assert_select "input[name=?]", "material[thc]"

      assert_select "input[name=?]", "material[cbd]"

      assert_select "input[name=?]", "material[terpene]"

      assert_select "input[name=?]", "material[drought]"

      assert_select "input[name=?]", "material[oil]"

      assert_select "input[name=?]", "material[edible]"

      assert_select "input[name=?]", "material[cost]"

      assert_select "input[name=?]", "material[owner_id]"
    end
  end
end
