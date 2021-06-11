# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures email is valid' do
      user = User.new(email: 'randomString', password: "1234512345123456")
      expect(user.save).to eq(false)
    end

    it 'ensures pasword length greater than 16 chars' do
      user = User.new(email: 'valid@email.com', password: '12345678910')
      expect(user.save).to eq(false)
    end

    it 'ensures user can be saved if valid' do
      user = build(:user)
      expect(user.save).to eq(true)
      user.destroy
    end

    it 'ensures a profile is created for every user created' do
      user = build(:user)
      user.save
      expect(user.profile.present?).to eq(true)
      user.destroy
    end
  end
end
