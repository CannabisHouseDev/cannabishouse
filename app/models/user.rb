class User < ApplicationRecord
  has_many :posts

  attr_accessor :agreement_1, :agreement_2, :agreement_3, :agreement_4
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
