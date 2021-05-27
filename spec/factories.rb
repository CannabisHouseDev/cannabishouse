# frozen_string_literal: true

FactoryBot.define do
  factory :transfer do
    sender_material { nil }
    reciever_material { nil }
    sender { nil }
    reciever { nil }
    weight { 1 }
  end

  factory :material do
    material_type { nil }
    name { "MyString" }
    description { "MyString" }
    weight { 1 }
    thc { "9.99" }
    cbd { "9.99" }
    terpene { "9.99" }
    drought { false }
    oil { false }
    edible { false }
    cost { "9.99" }
    owner { nil }
  end

  factory :material_type do
    
  end

  factory :user do
    email { 'john@example.com' }
    password { '1234123412341234' }
    password_confirmation { '1234123412341234' }
  end
  factory :profile do
    role { 0 }
    first_name { 'John' }
    last_name { 'Hammond' }
    nick_name { 'JK' }
    pesel { '88111132145' }
    gender { 0 }
    skills  { 'chess player, painter, roller' }
    contact_number { '555565777' }
    avatar { 'dlugiurldoobrazka' }
  end
end
