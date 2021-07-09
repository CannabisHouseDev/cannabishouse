# frozen_string_literal: true
password = Rails.application.credentials[Rails.env.to_sym][:admin][:password]
user = User.create email: 'konrad.rycerz@cannabishouse.eu', password: password, password_confirmation: password
user.build_profile role: 'admin', first_name: 'Konrad', last_name: 'Rycerz' 
puts 'Creating Question Types'
%w[short long number single multiple date].each do |t|
  QuestionType.create(name: t)
end

# need to have user with admin role
puts 'Creating onboarding Study'
Study.create(title: 'onboarding', description: 'Required surveys during onboarding', cycle: 4, max: 0, user_id: user.id)

puts 'Creating Pre-Psychiatrist Surveys'

Dir[Rails.root.join('db/seed/surveys/*.rb')].sort.each do |file|
  require file
end
