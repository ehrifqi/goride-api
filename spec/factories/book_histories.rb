# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :book_history do
    src_lat {Faker::Number.decimal(2, 5)}
    src_long {Faker::Number.decimal(2, 5)}
    dest_lat {Faker::Number.decimal(2, 5)}
    dest_long {Faker::Number.decimal(2, 5)}
    price {Faker::Number.number(5)}
    from {Faker::Address.street_name}
    to {Faker::Address.street_name}
    rating {3}
  end
end
