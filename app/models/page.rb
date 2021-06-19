# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id           :bigint           not null, primary key
#  body         :text
#  inner        :boolean          default(FALSE)
#  position     :integer
#  show_in_menu :boolean          default(FALSE)
#  slug         :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_pages_on_slug  (slug) UNIQUE
#
class Page < ApplicationRecord
  has_paper_trail
  extend FriendlyId
  friendly_id :title, use: :slugged

  scope :show_in_menu, -> { where(show_in_menu: true).order('position DESC') }

  has_rich_text :body

  def should_generate_new_friendly_id?
    title_changed?
  end
end
