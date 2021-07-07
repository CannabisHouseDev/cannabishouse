# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id              :bigint           not null, primary key
#  aasm_state      :string
#  avatar          :string
#  birth_date      :date
#  contact_number  :string
#  credits         :integer          default(0)
#  first_name      :string
#  gender          :integer
#  last_name       :string
#  locked          :boolean          default(FALSE)
#  nick_name       :string
#  old_state       :string
#  onboarded       :boolean          default(FALSE)
#  pesel           :string
#  quota_left_dry  :integer          default(0)
#  quota_left_oil  :integer          default(0)
#  quota_max_dry   :integer          default(0)
#  quota_max_oil   :integer          default(0)
#  risk            :string
#  risk_calculated :integer
#  role            :integer
#  skills          :string
#  verified        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  doctor_id       :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_profiles_on_doctor_id  (doctor_id)
#  index_profiles_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  include AASM
  has_paper_trail
  belongs_to :user

  alias_attribute :approved_by, :doctor_id

  has_one_attached :avatar

  enum role: %i[user participant admin dispensary researcher doctor warehouse],
       _default: 0

  enum gender: %i[male female]
  enum risk_calculated: %i[green orange red]

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :gender, presence: true, on: :update
  validates :pesel, presence: true, on: :update
  validates :contact_number, presence: true, on: :update
  # Removed until I fix :set_blob issue
  # validates :avatar, attached: true, content_type: 'image/png'

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

    event :fill_sixth, after: :calculate_risk do
      transitions to: :filled_all_surveys
    end

    event :pay do
      transitions to: :paid
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

  def set_quota(dry, oil, risk, approval)
    if approval
      self.update!(quota_left_dry: dry, quota_max_dry: dry, quota_left_oil: oil, quota_max_oil: oil, risk: risk)
      self.approve!
    else
      self.reject!
    end
  end

  def active_study
    sp = StudyParticipation.find_by(user_id: self.id)
    return sp ? sp : false;
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

  def calculate_risk
    # Test taken into concideration
    asset_test = %w[bMAST pum phq9 kssuk30]
    normalized_scores = []
    asset_test.each do |test|
      survey = FilledSurvey.find_by(user_id: self.user_id, survey: Survey.find_by(internal_name: test))
      # Rules for different risk assesment tests
      case test
      when 'bMAST'
        normalized_scores.push survey.score > 7 ? 2 : survey.score > 4 ? 1 : 0
      when 'pum'
        normalized_scores.push survey.score > 5 ? 2 : survey.score > 2 ? 1 : 0
      when 'phq9'
        normalized_scores.push survey.score > 14 ? 2 : survey.score > 9 ? 1 : 0
      when 'kssuk30'
        normalized_scores.push survey.score < 24 ? 2 : survey.score < 40 ? 1 : 0
      end
    end
    # All test have equal weight when deciding the final risk assesment
    total = (normalized_scores.sum / normalized_scores.count.to_f)
    self.risk_calculated = total > 1.5 ? 'red' : total > 0.5 ? 'orange' : 'green'
    save!
  end
end
