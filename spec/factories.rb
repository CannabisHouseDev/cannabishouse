# frozen_string_literal: true

FactoryBot.define do
  factory :contribution do
    contribution_type { 1 }
    end_date { "2021-07-07" }
    user { nil }
  end

  factory :study_participation do
    user { nil }
    study { nil }
  end

  factory :study do
    title { "MyString" }
    description { "MyString" }
    user { nil }
    max { 1 }
    fee { 1 }
    cycle { 1 }
  end

  factory :cycle do
    user { nil }
    annual_paid_on { "2021-06-30 10:28:54" }
    current_study_renews_on { "2021-06-30 10:28:54" }
    monthly_cycle_start_day { 1 }
  end


  factory :answer do
    filled_survey { nil }
    content { "MyString" }
  end

  factory :filled_survey do
    survey { nil }
    state { "MyString" }
    user { nil }
  end

  factory :appointment do
    time { "2021-06-22 20:59:49" }
    doctor { nil }
    participant { nil }
    state { 1 }
  end

  factory :question_option do
    name { "MyString" }
    question { nil }
  end

  factory :question do
    title { "MyString" }
    description { "MyString" }
    question_type { nil }
    survey { nil }
    min { 1 }
    max { 1 }
    placeholder { "MyString" }
  end

  factory :question_type do
    name { "MyString" }
  end

  factory :survey do
    title { "MyString" }
    description { "MyString" }
    user { nil }
  end

  factory :order_material do
    order { nil }
    material { nil }
  end

  factory :transfer do
    sender_material { nil }
    receiver_material { nil }
    sender { nil }
    receiver { nil }
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

  factory :dispensary do
    name { "WRO-1" }
    description { "MyString" }
    avatar { "MyString" }
    category { 0 }
    documents { "MyString" }
    verified { false }
    open { false }
    lat { "9.99" }
    lng { "9.99" }
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
