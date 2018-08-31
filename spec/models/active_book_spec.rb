require 'rails_helper'

RSpec.describe ActiveBook, type: :model do
  before :each do
    @member = create(:member)
    @driver = create(:driver)
    @order_status = create(:order_status, id: 1)
    @active_book = build(:active_book, member: @member, driver: @driver, order_status: @order_status)
  end

  it "has a valid factory" do 
    expect(@active_book).to be_valid
  end

  it "is invalid without a status" do
    @active_book.build_order_status(nil)
    @active_book.reload_order_status
    expect(@active_book).to_not be_valid
  end

  it "is invalid without a member" do
    @active_book.member = nil;
    expect(@active_book).to_not be_valid
  end

  it "is invalid without src_lat, src_long, dest_lat or dest_long" do
    @active_book.src_lat = nil
    @active_book.src_long = nil
    @active_book.dest_lat = nil
    @active_book.dest_long = nil
    expect(@active_book).to_not be_valid
  end

  it "is invalid without a price" do
    @active_book.price = nil
    expect(@active_book).to_not be_valid
  end

  it "is invalid without a from or to" do
    @active_book.from = nil
    @active_book.to = nil
    expect(@active_book).to_not be_valid
  end

  it "is valid without a driver" do
    @active_book.driver = nil;
    expect(@active_book).to be_valid
  end
end
