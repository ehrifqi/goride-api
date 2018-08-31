class ActiveBook < ApplicationRecord
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

  belongs_to :member
  belongs_to :driver, optional: true
  has_one :order_status, :class_name => "OrderStatus", :foreign_key => "id"
end
