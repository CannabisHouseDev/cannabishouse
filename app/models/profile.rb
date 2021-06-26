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
    state :filled_info, :consented, :locked_profile,
          :filled_first_survey, :filled_second_survey, :filled_third_survey,
          :filled_fourth_survey, :filled_fifth_survey, :filled_all_surveys,
          :paid, :booked, :approved, :rejected

    event :fill_info, before: :update_role do
      transitions from: :fresh, to: :filled_info
    end

    event :consent do
      transitions to: :consented
    end

    event :fill_first do
      transitions to: :filled_first_survey
    end

    event :fill_second do
      transitions to: :filled_second_survey
    end

    event :fill_third do
      transitions to: :filled_third_survey
    end

    event :fill_fourth do
      transitions to: :filled_fourth_survey
    end

    event :fill_fifth do
      transitions to: :filled_fifth_survey
    end

    event :fill_sixth do
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

    event :lock_profile, before: :save_old_state do
      transitions to: :locked_profile
    end
  end

  def fill_surveys!(ref)
    case ref.to_i
    when 1
      fill_first!
    when 2
      fill_second!
    when 3
      fill_third!
    when 4
      fill_fourth!
    when 5
      fill_fifth!
    when 6
      fill_sixth!
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

  def update_role
    self.role = 'participant' if self.role == 'user'
    save
  end
end
