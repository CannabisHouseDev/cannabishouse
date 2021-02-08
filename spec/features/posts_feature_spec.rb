require "rails_helper"

feature 'Posts' do
  context 'visit paths' do
    let!(:post) {create(:post, title: "test post title")}

    scenario 'post show path' do
      visit post_path(post.id)

      expect(current_path).to eq(post_path(post.id))
      expect(page).to have_content('test post title')
    end
  end
end
