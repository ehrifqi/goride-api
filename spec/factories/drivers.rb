# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :driver do
    email { Faker::Internet.email }
    password { Faker::String.random(10)}
    full_name { Faker::Name.name}
    phone_number { Faker::Number.number(12)}
    license_plate { Faker::String.random(8)}
    license_number { Faker::Number.number(12)}
    ktp_number { Faker::Number.number(16)}
    address { Faker::String.random(20)}
  end
end
