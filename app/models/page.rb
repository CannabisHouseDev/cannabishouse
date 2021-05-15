# frozen_string_literal: true

class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :show_in_menu, -> { where(show_in_menu: true).order('position DESC') }

  has_rich_text :body

  def should_generate_new_friendly_id?
    title_changed?
  end
end
