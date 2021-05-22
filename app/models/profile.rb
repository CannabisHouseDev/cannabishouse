# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

  validates :pesel, format: { with: /\A(\d{11})\z/, message: I18n.t('activerecord.attributes.profile.pesel_11_digit') },
                    if: :participant?

  enum role: %i[user participant admin dispensary researcher doctor warehouse],
       _default: 0

  enum gender: %i[male female]

  def participant?
    role == 1
  end
end
