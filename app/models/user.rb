class User < ApplicationRecord
  before_create :set_nickname

  enum role: [:user, :admin, :curator, :coordinator, :consultant, :editor, :researcher, :doctor]
  
  after_initialize :set_default_role, :if => :new_record?

  
  has_many :posts
  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
  
  attr_accessor :agreement_1, :agreement_2
  
  def set_default_role
    self.role ||= :user
  end

  def set_nickname
    self.nickname = self.first_name || "Nick##{7.times.map { rand(0..9) }.join}"
  end

  def gender
    if self.is_men == true
      "Mężczyzna"
    else
      "Kobieta"
    end
  end

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
