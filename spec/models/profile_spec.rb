require 'rails_helper'

RSpec.describe Profile, type: :model do
  
  context 'with valid attributes' do
    
    it 'should have valid role' do
      profile = build(:profile)
      expect(profile.role).to eq("user")
    end
    it 'should have valid first_name' do
      profile = build(:profile)
      expect(profile.first_name).to eq("John")
    end
    it 'should have valid last_name' do
      profile = build(:profile)
      expect(profile.last_name).to eq("Hammond")
    end
    it 'should have valid nick_name' do
      profile = build(:profile)
      expect(profile.nick_name).to eq("JK")
    end
    it 'should have valid pesel' do
      profile = build(:profile)
      expect(profile.pesel).to eq("88111132145")
    end
    it 'should have valid gender' do
      profile = build(:profile)
      expect(profile.gender).to eq("male")
    end
    it 'should have valid skills' do
      profile = build(:profile)
      expect(profile.skills).to eq("chess player, painter, roller")
    end
    it 'should have valid illness' do
      profile = build(:profile)
      expect(profile.illness).to eq("allergy")
    end
    it 'should have valid contact_number' do
      profile = build(:profile)
      expect(profile.contact_number).to eq("555565777")
    end
    it 'should have valid avatar' do
      profile = build(:profile)
      expect(profile.avatar).to eq("dlugiurldoobrazka")
    end
  end
end
