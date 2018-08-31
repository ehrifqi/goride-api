# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :active_book do
    src_lat {Faker::Number.decimal(2, 5)}
    src_long {Faker::Number.decimal(2, 5)}
    dest_lat {Faker::Number.decimal(2, 5)}
    dest_long {Faker::Number.decimal(2, 5)}
    price {Faker::Number.number(5)}
    from {Faker::Address.street_name}
    to {Faker::Address.street_name}
  end
end
