# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id             :bigint           not null, primary key
#  aasm_state     :string
#  avatar         :string
#  birth_date     :date
#  contact_number :string
#  credits        :integer          default(0)
#  first_name     :string
#  gender         :integer
#  last_name      :string
#  locked         :boolean          default(FALSE)
#  nick_name      :string
#  old_state      :string
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
  include AASM
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

  aasm do
    state :fresh, initial: true
    state :filled_info, :cleaning, :consented,
          :filled_first_survey, :filled_second_survey, :filled_third_survey,
          :filled_fourth_survey, :filled_fifth_survey, :filled_all_surveys,
          :paid, :booked, :approved, :rejected, :locked

    event :fill_info do
      transitions from: :fresh, to: :filled_info
    end

    event :fill_surveys do
      transitions to: :filled_first_survey
      transitions to: :filled_second_survey
      transitions to: :filled_third_survey
      transitions to: :filled_fourth_survey
      transitions to: :filled_fifth_survey
      transitions to: :filled_all_surveys
    end

    event :pay do
      transitions from: :filled_all_surveys, to: :paid
    end

    event :book do
      transitions to: :booked
    end

    event :approve do
      transitions from: :booked, to: :approved
    end

    event :paid do
      transitions from: :booked, to: :rejected
    end

    event :lock, before: :save_old_state do
      transitions to: :locked
    end
  end

  private

  def save_old_state
    self.old_state = aasm.current_state
    save
  end

  def old_aasm_state
    @old_state = old_state.to_sym
    @old_state
  end
end
