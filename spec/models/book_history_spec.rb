require 'rails_helper'

RSpec.describe BookHistory, type: :model do
  before :each do
    @member = create(:member)
    @driver = create(:driver)
    @order_status = create(:order_status, id: 1)
    @book_history = build(:book_history, member: @member, driver: @driver, order_status: @order_status)
  end

  it "has a valid factory" do 
    expect(@book_history).to be_valid
  end

  it "is invalid without a status" do
    @book_history.build_order_status(nil)
    @book_history.reload_order_status
    expect(@book_history).to_not be_valid
  end

  it "is invalid without a member" do
    @book_history.member = nil;
    expect(@book_history).to_not be_valid
  end

  it "is invalid without src_lat, src_long, dest_lat or dest_long" do
    @book_history.src_lat = nil
    @book_history.src_long = nil
    @book_history.dest_lat = nil
    @book_history.dest_long = nil
    expect(@book_history).to_not be_valid
  end

  it "is invalid without a price" do
    @book_history.price = nil
    expect(@book_history).to_not be_valid
  end

  it "is invalid without a from or to" do
    @book_history.from = nil
    @book_history.to = nil
    expect(@book_history).to_not be_valid
  end

  it "is invalid without a driver" do
    @book_history.driver = nil;
    expect(@book_history).to_not be_valid
  end

  it "is valid without a rating" do
    @book_history.rating = nil
    expect(@book_history).to be_valid
  end

  it "is valid with a rating between 0 - 5" do
    @book_history.rating = 4
    expect(@book_history).to be_valid
  end

  it "is invalid with a rating not between 0 - 5" do
    @book_history.rating = 8
    expect(@book_history).to_not be_valid
  end
end
