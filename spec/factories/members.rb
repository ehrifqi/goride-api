# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    email { Faker::Internet.email }
    password { Faker::String.random(10)}
  end
end