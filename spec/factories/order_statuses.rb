# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order_status do
    status {"Pending"}
  end

  factory :pending, class: OrderStatus do
    status { "Pending" }
  end
  factory :accepted, class: OrderStatus do
    status { "Accepted" }
  end
  factory :picked_up, class: OrderStatus do
    status { "Picked Up" }
  end
  factory :arrived, class: OrderStatus do
    status { "Arrived" }
  end
  factory :canceled_by_driver, class: OrderStatus do
    status { "Canceled by Driver" }
  end
  factory :canceled_by_member, class: OrderStatus do
    status { "Canceled by Member" }
  end
end
