# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar

<<<<<<< HEAD
  validates :pesel, format: { with: /\A(\d{11})\z/, message: I18n.t('activerecord.attributes.profile.pesel_11_digit')}, if: :participant?
  
  enum role: %i[ user participant admin curator coordinator consultant editor researcher doctor ], _default: 0

  enum gender: %i[ male female ]
=======
  validates :pesel, format: { with: /\A(\d{11})\z/, message: I18n.t('activerecord.attributes.profile.pesel_11_digit') },
                    if: :participant?

  enum role: %i[user participant admin curator coordinator consultant editor researcher doctor],
       _default: 0

  enum gender: %i[male female]
>>>>>>> master

  def participant?
    role == 1
  end
end
