# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_paper_trail
  after_create :create_user_profile
  has_one :cycle

  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses, reject_if: ->(attributes) { attributes['name'].blank? }, allow_destroy: true

  has_many :posts

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, reject_if: ->(attributes) { attributes['name'].blank? }, allow_destroy: true

  has_many :materials, class_name: 'Material', foreign_key: 'owner_id', dependent: :destroy

  has_many :orders

  has_one :study_participation
  has_many :surveys, dependent: :destroy

  has_many :appointments, class_name: 'Appointment', foreign_key: 'participant_id'
  has_many :appointments, class_name: 'Appointment', foreign_key: 'doctor_id'
  
  attr_accessor :agreement_1, :agreement_2

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def create_user_profile
    create_profile
  end

  def onboarded?
    profile.onboarded || false
  end

  def verified?
    profile.verified || false
  end

  def booked?
    Appointment.find_by(participant_id: id).exists?
  end

  def approved?
    profile.aasm_state == 'approved'
  end

  private

  def agreements_checked
    if !persisted? && !(agreement_1 == 'true' && agreement_2 == 'true')
      errors.add(:base,
                 t('models.user.agreements_checked'))
    end
  end
end
