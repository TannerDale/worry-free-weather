FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'hello' }
    password_confirmation { 'hello' }
  end
end
