require 'rails_helper'

RSpec.describe Api::V1::ActiveBooksController, type: :controller do
  before :each do
    @member = create(:member)
    @member2 = build(:member)
    @driver = create(:driver)
    @driver2 = build(:driver)
    @order_status = create(:order_status, id: 1)
    @active_book = build(:active_book, member: @member, driver: @driver, order_status: @order_status)
  end

  describe "/POST create_active_book" do
  	before :each do |test|
  	  merge_header(auth_headers(@member.id,Rails.application.secrets.role_member)) unless test.metadata[:logged_out]
  	end

  	it "returns HTTP 200 on successful creation" do
  	  post "create_active_book", params: {
  	  	member_id: @active_book.member_id,
  		driver_id: @active_book.driver_id,
  		order_status_id: @active_book.order_status_id,
  		src_lat: @active_book.src_lat,
  		src_long: @active_book.src_long,
  		dest_lat: @active_book.dest_lat,
  		dest_long: @active_book.dest_long,
  		price: @active_book.price,
  		from: @active_book.from,
  		to: @active_book.to
  	  }
  	  expect(response.status).to eq(200)
  	end

  	it "regenerate a valid token on successful creation" do
  		post "create_active_book", params: {
  	  	member_id: @active_book.member_id,
  		driver_id: @active_book.driver_id,
  		order_status_id: @active_book.order_status_id,
  		src_lat: @active_book.src_lat,
  		src_long: @active_book.src_long,
  		dest_lat: @active_book.dest_lat,
  		dest_long: @active_book.dest_long,
  		price: @active_book.price,
  		from: @active_book.from,
  		to: @active_book.to
  	  }
  	  expect(response_json).to include("token")
  	end
  end

  describe "GET/ get_by_member" do
  	before :each do |test|
  	  merge_header(auth_headers(@member.id,Rails.application.secrets.role_member)) unless test.metadata[:logged_out]
  	end

  	it "returns HTTP 200 on successful get_by_member" do
  	  get "get_by_member", params: {
  	  	member_id: @member.id
  	  }
  	  expect(response.status).to eq(200)
  	end

  	it "regenerate a valid token on successful get_by_member" do
  		get "get_by_member", params: {
  	  	member_id: @member2.id
  	  }
  	  expect(response_json).to include("token")
  	end
  end

  describe "GET/ get_by_driver" do
  	before :each do |test|
  	  merge_header(auth_headers(@driver.id,Rails.application.secrets.role_driver)) unless test.metadata[:logged_out]
  	end
  	
  	it "returns HTTP 200 on successful get_by_driver" do
  	  get "get_by_driver", params: {
  	  	member_id: @driver.id
  	  }
  	  expect(response.status).to eq(200)
  	end

  	it "regenerate a valid token on successful get_by_driver" do
  		get "get_by_driver", params: {
  	  	member_id: @driver2.id
  	  }
  	  expect(response_json).to include("token")
  	end
  end
end
