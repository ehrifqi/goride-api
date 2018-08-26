# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :driver_detail do
  	curr_lat { Faker::Number.decimal }
  	curr_long { Faker::Number.decimal }
  	is_active { Faker::Boolean.boolean }
  end
end
