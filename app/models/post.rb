# frozen_string_literal: true

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
