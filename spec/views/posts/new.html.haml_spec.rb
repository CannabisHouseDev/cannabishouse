require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      title: "MyString",
      body: "MyText",
      status: 1,
      user: nil,
      image: "MyString",
      slug: "MyString",
      inner: false
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input[name=?]", "post[title]"

      assert_select "textarea[name=?]", "post[body]"

      assert_select "input[name=?]", "post[status]"

      assert_select "input[name=?]", "post[user_id]"

      assert_select "input[name=?]", "post[image]"

      assert_select "input[name=?]", "post[slug]"

      assert_select "input[name=?]", "post[inner]"
    end
  end
end
