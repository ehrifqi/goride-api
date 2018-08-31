# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member_detail do
  	curr_lat { Faker::Number.decimal }
  	curr_long { Faker::Number.decimal }
  end
end
