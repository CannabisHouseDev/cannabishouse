class User < ApplicationRecord
  has_many :posts
  has_many :addresses, inverse_of: :user
  accepts_nested_attributes_for :addresses, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
  
  attr_accessor :agreement_1, :agreement_2
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  
  private
  
  def agreements_checked
    unless self.persisted?
      self.errors.add(:base, 'Proszę zaakceptować oświadczenia.') unless self.agreement_1 == 'true'  && self.agreement_2 == 'true'
    end
  end
  
end
