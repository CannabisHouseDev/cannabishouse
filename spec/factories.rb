FactoryBot.define do
  factory :user do
    email { "john@example.com" }
    password  { "1234123412341234" }
    password_confirmation { "1234123412341234" }
  end
end