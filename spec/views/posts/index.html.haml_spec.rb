require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        title: "Title",
        body: "MyText",
        status: 2,
        user: nil,
        image: "Image",
        slug: "Slug",
        inner: false
      ),
      Post.create!(
        title: "Title",
        body: "MyText",
        status: 2,
        user: nil,
        image: "Image",
        slug: "Slug",
        inner: false
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Image".to_s, count: 2
    assert_select "tr>td", text: "Slug".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
