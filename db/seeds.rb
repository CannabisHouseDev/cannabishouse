# frozen_string_literal: true
puts 'Destroying old records...'
Transfer.destroy_all
MaterialType.destroy_all
User.destroy_all
Material.destroy_all
Profile.destroy_all
Address.destroy_all

url = Faker::Avatar.image(slug: 'avatar', size: '250x250')
filename = File.basename(URI.parse(url).path)

puts 'Creating users...'
6.times do |i|
  user = User.create(
    email: "#{%w[user participant dispensary doctor researcher warehouse admin][i]}@cannabishouse.eu",
    password: '1111222233334444',
    password_confirmation: '1111222233334444',
    agreement_1: 'true',
    agreement_2: 'true')
  user.save
  user.confirm
  file = URI.open(url)
  user.profile.avatar.attach(io: file, filename: filename, content_type: "image/jpg")
  user.profile.update(
    role: %w[user participant dispensary doctor researcher warehouse admin][i],
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: rand(0..1),
    contact_number: Faker::PhoneNumber.phone_number,
    pesel: '19293012949')
  user.profile.onboarded = true unless i.zero?
  user.profile.verified = true unless i.zero?
  user.profile.quota_max = 100 if i == 1
  user.profile.quota_left = 100 if i == 1
  user.profile.credits = 10_000_000 if i == 1
  user.profile.save
  puts "created #{user.profile.first_name}:#{user.id} with role #{user.profile.role}"
end

puts 'Creating MaterialTypes'
3.times do |i|
  MaterialType.create(name: %w[Sativa Indica Hybrid][i])
end

puts 'Creating Material'
10.times do |i|
  material = Material.create(
    material_type: MaterialType.all.sample,
    name: Faker::Cannabis.strain,
    description: "Description #{i}",
    weight: 1000,
<<<<<<< HEAD
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

puts 'Creating Question Types'
%w[short long number single multiple date].each do |t|
  QuestionType.create(name: t)
end

puts 'Creating Surveys'
3.times do |i|
  s = Survey.create(title: "Survey #{i}", description: 'An example description of the survey', author: Profile.find_by(role: 'researcher').user.id)
  QuestionType.all.each do |qt|
    q = Question.create(title: qt.name, description: "An example of a #{qt.name} question", question_type_id: qt.id, survey_id: s.id)
    case qt.name
    when 'short' || 'long'
      q.placeholder = 'placeholder'
    when 'single' || 'multiple'
      3.times do
        QuestionOption.create(question_id: q.id, name: Faker::Cannabis.strain)
      end
    when 'number'
      q.min = 10
      q.max = 100
      q.save!
    end
=======
    thc: rand(0..40),
    cbd: rand(0..40),
    terpene: rand(0..40),
    drought: !(i % 5).zero?,
    oil: (i % 5).zero?,
    edible: (i % 5).zero?,
    cost: (i % 5).zero? ? 12_000 : 4000,
    owner_id: Profile.find_by(role: 'warehouse').user_id)
  material.save!
  puts "Created #{material.name} ##{material.id}"
end

puts 'Transferring Material from Warehouse to Dispensary'
Material.all.each do |material|
  transfer = material.split(Profile.find_by(role: 'dispensary').user, 1000)
  if transfer[0]
    puts "Transferred #{transfer[1].weight} grams of #{material.name} to dispensary"
  else
    puts "Could not transfer #{material.name}, message: #{m[1]}"
  end
end

puts 'Transferring Material from Dispensary to Participant'
Material.where(owner_id: Profile.find_by(role: 'dispensary').user).each do |material|
  transfer = material.split(Profile.find_by(role: 'participant').user, 30)
  if transfer[0]
    puts "Transferred #{transfer[1].weight} grams of #{material.name} to participant"
  else
    puts "Could not transfer #{material.name}, message: #{m[1]}"
>>>>>>> dispensary_flo
  end
end
