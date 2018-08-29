class OrderStatus < ApplicationRecord
  validates :status, presence: :true, uniqueness: true
end
