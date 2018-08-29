require 'rails_helper'

RSpec.describe OrderStatus, type: :model do
  before :each do
    @pending = create(:pending)
    @accepted = create(:accepted)
    @picked_up = create(:picked_up)
    @arrived = create(:arrived)
    @canceled_by_driver = create(:canceled_by_driver)
    @canceled_by_member = create(:canceled_by_member)
  end

  it "has a valid factory, and is valid with a unique status" do
    expect(@pending).to be_valid
    expect(@accepted).to be_valid
    expect(@picked_up).to be_valid
    expect(@arrived).to be_valid
    expect(@canceled_by_driver).to be_valid
    expect(@canceled_by_member).to be_valid
  end

  it "is invalid without a status property" do
    order_status = OrderStatus.new()
    expect(order_status).to_not be_valid
  end

  it "is invalid with a duplicate status" do
    order_status = OrderStatus.new(status: @pending.status)
    expect(order_status).to_not be_valid
  end
end
