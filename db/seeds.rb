#require 'roo'

User.destroy_all
Post.destroy_all
Page.destroy_all

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
puts 'create users'
users_list.each do |hash|
  user = User.new hash
  user.skip_confirmation!
  user.save!
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