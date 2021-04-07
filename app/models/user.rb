class User < ApplicationRecord
  after_create :create_user_profile
  
  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
  
  has_many :posts
  
  has_one :profile
  accepts_nested_attributes_for :profile, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
  
  attr_accessor :agreement_1, :agreement_2
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable, :confirmable
  
  def create_user_profile
    self.create_profile
  end

  private
  
  def agreements_checked
    unless self.persisted?
      self.errors.add(:base, 'Proszę zaakceptować oświadczenia.') unless self.agreement_1 == 'true'  && self.agreement_2 == 'true'
    end
  end
end
