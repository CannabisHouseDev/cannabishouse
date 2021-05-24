# frozen_string_literal: true

class Profile < ApplicationRecord
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

  validates :pesel, format: { with: /\A(\d{11})\z/ }, on: :update

end
