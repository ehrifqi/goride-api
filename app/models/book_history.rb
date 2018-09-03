class BookHistory < ApplicationRecord
  validates :member_id, presence: true
  validates :driver_id, presence: false
  validates :order_status_id, presence: true

  validates :src_lat, presence: true
  validates :src_long, presence: true
  validates :dest_lat, presence: true
  validates :dest_long, presence: true
  validates :price, presence: true
  validates :from, presence: true
  validates :to, presence: true
  validates :rating, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  validates :distance, presence: true

  belongs_to :member
  belongs_to :driver, optional: true
  belongs_to :order_status
end
