# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id             :bigint           not null, primary key
#  avatar         :string
#  birth_date     :date
#  contact_number :string
#  credits        :integer          default(0)
#  first_name     :string
#  gender         :integer
#  last_name      :string
#  locked         :boolean          default(FALSE)
#  nick_name      :string
#  onboarded      :boolean          default(FALSE)
#  pesel          :string
#  quota_left     :integer          default(0)
#  quota_max      :integer          default(0)
#  role           :integer
#  skills         :string
#  verified       :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  has_paper_trail
  belongs_to :user

  has_one_attached :avatar

  enum role: %i[user participant admin dispensary researcher doctor warehouse],
       _default: 0

  enum gender: %i[male female]

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :gender, presence: true, on: :update
  validates :pesel, presence: true, on: :update
  validates :contact_number, presence: true, on: :update
  validates :avatar, attached: true, content_type: 'image/png'

  validates :pesel, format: { with: /\A(\d{11})\z/ }, on: :update

  def avatar_path
    ActiveStorage::Blob.service.path_for(avatar.key)
  end
end
