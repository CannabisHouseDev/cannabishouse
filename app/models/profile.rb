class Profile < ApplicationRecord
  belongs_to :user
  
  has_one_attached :avatar

  validates :pesel, format: { with: /\A(\d{11})\z/, message: I18n.t('activerecord.attributes.profile.pesel_11_digit')}, if: :participant?
  
  enum role: %i[:user, :participant, :admin, :curator, :coordinator, :consultant, :editor, :researcher, :doctor], _default: 0

  enum gender: [:male, :female]

  def participant?
    self.role == 1
  end
end
