FactoryBot.define do
  factory :user do
    email { "john@example.com" }
    password  { "1234123412341234" }
    password_confirmation { "1234123412341234" }
  end
  factory :profile do
    role { 0 }
    first_name { "John" }
    last_name { "Hammond" }
    nick_name { "JK" }
    pesel { "88111132145" }
    gender { 0 }
    skills  { "chess player, painter, roller" }
    illness { "allergy" }
    contact_number { "555565777" }
    avatar { "dlugiurldoobrazka" }
  end
end