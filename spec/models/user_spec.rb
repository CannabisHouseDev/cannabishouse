# frozen_string_literal: true

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
