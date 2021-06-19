# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  body       :text
#  image      :string
#  inner      :boolean
#  post_date  :datetime
#  slug       :string
#  status     :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  has_paper_trail
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user

  enum status: %i[draft published blog archived]

  paginates_per 10

  has_rich_text :body
  # TODO: mount_uploader
end
