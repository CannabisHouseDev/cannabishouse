#require 'roo'

Post.delete_all
Page.delete_all
Address.delete_all
Profile.delete_all
User.delete_all
Dispensary.delete_all

users_list = [
  { email: 'wolak88@gmail.com', password: 'wierd123321_16charsmin', password_confirmation: 'wierd123321_16charsmin', #role: 2,
    agreement_1: 'true',
    agreement_2: 'true', },
  { email: 'tomasz.slota@cannabishouse.eu', password: 'wierd123321_16charsmin', password_confirmation: 'wierd123321_16charsmin',
    agreement_1: 'true',
    agreement_2: 'true',},
  { email: 'konrad.rycerz@cannabishouse.eu', password: 'cannabishouse_123123123', password_confirmation: 'cannabishouse_123123123', #role: 2,
    agreement_1: 'true',
    agreement_2: 'true',},
]
puts 'create users list'
(1..47).each do
  users_list << {
    email: Faker::Internet.email,
    password: 'wierd123321_16charsmin',
    password_confirmation: 'wierd123321_16charsmin',
    agreement_1: 'true',
    agreement_2: 'true',  
  }
end
puts 'create profiles'
profiles_list = []
(1..50).each do
  profiles_list << {
    role: rand(0..8),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nick_name: Faker::Games::LeagueOfLegends.champion,
    pesel: "19293012949",
    gender: rand(0..1),
    skills:  Faker::Lorem.words(number: 4),
    illness: Faker::Lorem.words(number: 4),
    contact_number: Faker::PhoneNumber.phone_number
  }
end
puts 'addresses build'
addresses_list = []
(1..50).each do |x|
  addresses_list << {
    street1: Faker::Address.street_name, 
    street2: "#{rand(1..500)}", 
    city: Faker::Address.city, 
    province: rand(0..15), 
    zip_code: "#{rand(0..9)}#{rand(0..9)}-#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}", 
    country: "Polska", 
    category: rand(0..2),
  }
end

puts 'create users'
users_list.each do |hash|
  user = User.new hash
  user.skip_confirmation!
  user.save!
  user.profile.update profiles_list.pop
  user.profile.save!
  user.addresses.create! addresses_list.pop
end

puts "time for Dispensaries"
dispensaries_list = [
  { name: "Dyspensarium - Gdańsk 1", description: "GD 1", category: 0, verified: true, open: true, lat: 54.352628,lng: 18.6513903 },
  { name: "Dyspensarium - Legionowo 1", description: "LEG 1", category: 0, verified: true, open: true, lat: 52.3991,lng: 20.9367, },
  { name: "Dyspensarium - Poznań 1", description: "PZN 1", category: 0, verified: true, open: true, lat: 52.4111,lng: 16.8959, },
  { name: "Dyspensarium - Bydgoszcz 1", description: "BDG 1", category: 0, verified: true, open: true, lat: 53.1338,lng: 18.0113, },
  { name: "Dyspensarium - Szczecin 1", description: "SCZ 1", category: 0, verified: true, open: true, lat: 53.43585,lng: 14.5544, }
]
dispensaries_list.each do |d|
  disp = Dispensary.new d
  disp.save!
end

# This is temporary solution for development
puts "Let's create Pages :D"
pages = Page.create([{title: Faker::Games::LeagueOfLegends.masteries, body: "<h1> TEST<br><p>Testowy paragraph", slug: "testowa-strona", show_in_menu: true, position: 1}, 
                     {title: "Stowarzyszenie", body: Faker::Lorem.paragraph(sentence_count: 23), slug: "stowarzyszenie", show_in_menu: true, position: 2},
                     {title: "Badania", body: Faker::Lorem.paragraph(sentence_count: 25), slug: "badania", show_in_menu: true, position: 102},
                     {title: "O Nas", body: Faker::Lorem.paragraph(sentence_count: 44), slug: "o_nas", show_in_menu: true, position: 105},
                    ])

puts "Generating posts ;)"
posts = 30.times do Post.create!({title: Faker::Games::LeagueOfLegends.masteries,
                                 body: "#{Faker::Lorem.paragraph(sentence_count: 30)}",
                                 status: [:draft, :published, :archived, :blog].sample,
                                 post_date: Date.today-rand(3..10).days,
                                 user_id: User.where(email:'konrad.rycerz@cannabishouse.eu').first.id,
                                 inner: false
                                 })
end

# TODO: We should import our posts and pages from production DB

# file_path = Rails.root.join('db', 'data.xlsx')
# spreadsheet = Roo::Excelx.new(file_path)
# # spreadsheet = Roo::open_spreadsheet(file)
# header = spreadsheet.sheet(0).row(1)
# (2..spreadsheet.sheet(0).last_row).each do |i|
#   post_params = Hash[[header, spreadsheet.sheet(0).row(i)].transpose]
#   post_params[:user] = User.where(email: "konrad.rycerz@cannabishouse.eu").first
#   post_params[:post_date] = Date.today-rand(5..30).days
#   Post.create!(post_params)
# end

# header = spreadsheet.sheet(1).row(1)
# (2..spreadsheet.sheet(1).last_row).each do |i|
#   page_params = Hash[[header, spreadsheet.sheet(1).row(i)].transpose]
#   page_params[:show_in_menu] = true
#   Page.create!(page_params)
# end