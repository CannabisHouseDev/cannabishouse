# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id              :bigint           not null, primary key
#  aasm_state      :string
#  avatar          :string
#  birth_date      :date
#  contact_number  :string
#  credits         :integer          default(0)
#  first_name      :string
#  gender          :integer
#  last_name       :string
#  locked          :boolean          default(FALSE)
#  nick_name       :string
#  old_state       :string
#  onboarded       :boolean          default(FALSE)
#  pesel           :string
#  quota_left_dry  :integer          default(0)
#  quota_left_oil  :integer          default(0)
#  quota_max_dry   :integer          default(0)
#  quota_max_oil   :integer          default(0)
#  risk            :string
#  risk_calculated :integer
#  role            :integer
#  skills          :string
#  verified        :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  doctor_id       :bigint
#  user_id         :bigint           not null
#
# Indexes
#
#  index_profiles_on_doctor_id  (doctor_id)
#  index_profiles_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (doctor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  User.find_by(email: 'valid@gmail.com').destroy if User.find_by(email: 'valid@gmail.com')
  user = User.create(email: 'valid@gmail.com', password: '123456123456123456')
  image = ActiveStorage::Blob.create_after_upload!(
            io: URI.open('https://picsum.photos/200'),
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
