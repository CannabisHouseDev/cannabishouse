# frozen_string_literal: true

puts 'Deleting old data...'
Post.delete_all
Page.delete_all
Address.delete_all
Profile.delete_all
User.delete_all
Dispensary.delete_all
MaterialType.delete_all

url = Faker::Avatar.image(slug: 'avatar', size: '250x250')
filename = File.basename(URI.parse(url).path)

puts 'Creating users...'
for i in 0..6 do
  user = User.create(
    email: "#{["user", "participant", "dispensary", "doctor", "researcher", "warehouse", "admin"][i]}@cannabishouse.eu",
    password: '1111222233334444',
    password_confirmation: '1111222233334444',
    agreement_1: 'true',
    agreement_2: 'true'
    )
  user.save
  user.confirm
  file = URI.open(url)
  user.profile.avatar.attach(io: file, filename: filename, content_type: "image/jpg")
  user.profile.update(
    role: ["user", "participant", "dispensary", "doctor", "researcher", "warehouse", "admin"][i],
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: rand(0..1),
    contact_number: Faker::PhoneNumber.phone_number,
    pesel: '19293012949'
    )
  user.profile.onboarded = true unless i == 0
  user.profile.verified = true unless i == 0
  user.profile.save
  puts "created #{user.profile.first_name}:#{user.id} with role #{user.profile.role}"
end

puts 'Creating MaterialTypes'
for i in 0..2 do
  material = MaterialType.create(
  name:"#{["Sativa", "Indica", "Hybrid"][i]}")
  material.save
end