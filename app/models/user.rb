# frozen_string_literal: true

class User < ApplicationRecord
  after_create :create_user_profile

  has_many :addresses, as: :addressable
<<<<<<< HEAD
  accepts_nested_attributes_for :addresses, reject_if: ->(attributes){ attributes['name'].blank? }, allow_destroy: true
  
  has_many :memberships
  has_many :dispensaries, :through => :memberships
  
=======
  accepts_nested_attributes_for :addresses, reject_if: ->(attributes) { attributes['name'].blank? }, allow_destroy: true

>>>>>>> master
  has_many :posts

  has_one :profile
  accepts_nested_attributes_for :profile, reject_if: ->(attributes) { attributes['name'].blank? }, allow_destroy: true

  attr_accessor :agreement_1, :agreement_2

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  def create_user_profile
    create_profile
  end

  private

  def agreements_checked
    if !persisted? && !(agreement_1 == 'true' && agreement_2 == 'true')
      errors.add(:base,
                 t('models.user.agreements_checked'))
    end
  end
end
