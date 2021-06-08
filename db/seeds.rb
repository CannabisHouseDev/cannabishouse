# frozen_string_literal: true

puts 'Deleting old data...'
Post.delete_all
Page.delete_all
Address.delete_all
Profile.delete_all
User.delete_all
Dispensary.delete_all
MaterialType.delete_all
Material.delete_all
Transfer.delete_all

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
material_type_ids = (0..2).collect do |i|
  MaterialType.create(
  name:"#{["Sativa", "Indica", "Hybrid"][i]}")
end.pluck(:id)

puts 'Creating Material'
10.times do |i|
  material = Material.create(
    material_type_id: material_type_ids.sample,
    name: Faker::Cannabis.strain,
    description: "Description #{i}",
    weight: 1000,
    thc: rand(0..0.4).round(2),
    cbd: rand(0..0.4).round(2),
    terpene: rand(0..0.4).round(2),
    drought: i % 5 != 0,
    oil: i % 5 == 0,
    edible: i % 5 == 0,
    cost: i % 5 == 0 ? 120 : 40,
    owner_id: Profile.find_by(role: "warehouse").user_id)
  dispensary_material = material.split(Profile.find_by(role: "dispensary").user, 1000)
  dispensary_material.split(Profile.find_by(role: "participant").user, 5)
end