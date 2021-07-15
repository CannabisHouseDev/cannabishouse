# frozen_string_literal: true
Profile.destroy_all
User.destroy_all
QuestionOption.destroy_all
QuestionType.destroy_all
Question.destroy_all
Survey.destroy_all

password = '1111222233334444'
user = User.create email: 'konrad.rycerz@cannabishouse.eu', password: password, password_confirmation: password, agreement_1: true, agreement_2: true
user.build_profile role: 'admin', first_name: 'Konrad', last_name: 'Rycerz' 
puts 'Creating Question Types'
%w[short long number single multiple date].each do |t|
  QuestionType.create(name: t)
end

# need to have user with admin role
puts 'Creating Badanie Biologiczne Study'
Study.create(title: 'Badanie Biologiczne',
             description: 'Required surveys during onboarding',
             cycle: 4,
             max: 0,
             user_id: user.id)

puts 'Creating Badanie Biologiczne Surveys'

Dir[Rails.root.join('db/seed/surveys/*.rb')].sort.each do |file|
  require file
end
