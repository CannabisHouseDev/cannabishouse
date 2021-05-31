# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  User.find_by(email: 'valid@gmail.com').destroy if User.find_by(email: 'valid@gmail.com')
  user = User.create(email: 'valid@gmail.com', password: '123456123456123456')
  image = ActiveStorage::Blob.create_after_upload!(
            io: File.open(Rails.root.join('spec', 'support', 'test_avatar.jpg'), 'rb'),
            filename: 'test_avatar.jpg',
            content_type: 'image/jpeg').signed_id
  user.profile.update(first_name: "John",
                      last_name: "Hammond",
                      pesel: "88111132145",
                      gender: "male",
                      contact_number: "555565777",
                      avatar: image)
  context 'validation tests' do
    it 'first name must be present' do
      expect(user.profile.update(first_name: nil)).to eq(false)
    end

    it 'last name must be present' do
      expect(user.profile.update(last_name: nil)).to eq(false)
    end

    it 'pesel must be present' do
      expect(user.profile.update(pesel: nil)).to eq(false)
    end

    it 'pesel must be an 11 digit integer' do
      expect(user.profile.update(pesel: "12345678")).to eq(false)
    end

    it 'pesel must be an 11 digit integer' do
      expect(user.profile.update(pesel: "12345678324234")).to eq(false)
    end

    it 'pesel must be an 11 digit integer' do
      expect(user.profile.update(pesel: "123456789a1")).to eq(false)
    end

    it 'contact number must be present' do
      expect(user.profile.update(contact_number: nil)).to eq(false)
    end

    it 'gender must be present' do
      expect(user.profile.update(gender: nil)).to eq(false)
    end

    it 'avatar be present' do
      expect(user.profile.update(avatar: nil)).to eq(false)
    end

    it 'must save if valid' do
      user.profile.update(first_name: "John",
                          last_name: "Hammond",
                          pesel: "88111132145",
                          gender: "male",
                          contact_number: "555565777",
                          avatar: image)
      expect(user.profile.valid?).to eq(true)
    end
  end
end
