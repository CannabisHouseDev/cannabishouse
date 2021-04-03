class Profile < ApplicationRecord
  belongs_to :user
  
  validates :pesel, format: { with: /\A(\d{11})\z/, message: I18n.t('activerecord.attributes.profile.pesel_11_digit')}

  enum role: [:user, :admin, :curator, :coordinator, :consultant, :editor, :researcher, :doctor]
end
