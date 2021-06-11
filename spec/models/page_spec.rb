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
require 'rails_helper'

RSpec.describe Page, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
