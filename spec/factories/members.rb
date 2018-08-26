# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    email { Faker::Internet.email }
    password { Faker::String.random(10)}
    full_name {Faker::Name.name}
    phone_number {Faker::String.random(12)}
  end
end