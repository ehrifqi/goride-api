require 'rails_helper'

RSpec.describe Api::V1::ActiveBooksController, type: :controller do
  before :each do
    @member = create(:member)
    @member2 = create(:member)
    @driver = create(:driver)
    @driver2 = create(:driver)
    @order_status = create(:order_status, id: 1)
    @order_status2 = create(:order_status, id: 5, status: 'Canceled by Driver')
    @active_book = build(:active_book, member: @member, driver: @driver, order_status: @order_status)
    @active_book2 = create(:active_book, member: @member, driver: @driver, order_status: @order_status)
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
			to: @active_book.to,
			distance: @active_book.distance,
			price_with_gopay: @active_book.price_with_gopay
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
			to: @active_book.to,
			distance: @active_book.distance,
			price_with_gopay: @active_book.price_with_gopay
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
  	  	member_id: @member.id
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
  	  	driver_id: @driver.id
  	  }
  	  expect(response.status).to eq(200)
  	end

  	it "regenerate a valid token on successful get_by_driver" do
  		get "get_by_driver", params: {
  	  	driver_id: @driver.id
  	  }
  	  expect(response_json).to include("token")
  	end
	end

  describe '/PATCH set_driver' do
    before :each do |test|
      merge_header(auth_headers(@driver.id,Rails.application.secrets.role_member)) unless test.metadata[:logged_out]
    end

    it 'should return HTTP OK' do
      patch "set_driver", params: {
        id: @active_book2.id,
        driver_id: @driver2.id
      }
      expect(response.status).to eq(200)
    end

    it 'should render a json with key {active_book, token}' do
      patch "set_driver", params: {
        id: @active_book2.id,
        driver_id: @driver2.id
      }
      expect(response_json).to include("active_book", "token")
    end

    it 'should set new driver_id and order_status_id equals to 2 with the specified id' do
      patch "set_driver", params: {
        id: @active_book2.id,
        driver_id: @driver2.id
      }
      active_book = response_json["active_book"]
      expect(active_book["id"]).to eq(@active_book2.id)
      expect(active_book["driver_id"]).to eq(@driver2.id)
      expect(active_book["order_status_id"]).to eq(2)
    end
  end

  describe '/PATCH set_status' do
    before :each do |test|
      merge_header(auth_headers(@driver.id,Rails.application.secrets.role_member)) unless test.metadata[:logged_out]
    end

    it 'should return HTTP OK' do
      patch "set_status", params: {
        id: @active_book2.id,
        order_status_id: 5
      }
      expect(response.status).to eq(200)
    end
    
    it 'should render a json with key {active_book, token}' do
      patch "set_status", params: {
        id: @active_book2.id,
        order_status_id: 5
      }
      expect(response_json).to include("active_book", "token")
    end

    it 'should set new order_status_id into the specified id' do
      patch "set_status", params: {
        id: @active_book2.id,
        order_status_id: 5
      }
      active_book = response_json["active_book"]
      expect(active_book["id"]).to eq(@active_book2.id)
      expect(active_book["order_status_id"]).to eq(5)
    end
  end
	
	describe '/DELETE move_to_history' do
		before :each do |test|
  	  merge_header(auth_headers(@driver.id,Rails.application.secrets.role_member)) unless test.metadata[:logged_out]
		end
		
		it 'should return HTTP OK' do
			@active_book.save
			length_before_delete = ActiveBook.all.length

			delete 'remove_active_book', params: {id: @active_book["id"]}
			expect(response.status).to eq(200)
		end

		it 'should delete an activeBook' do
			@active_book.save
			length_before_delete = ActiveBook.all.length

			delete 'remove_active_book', params: {id: @active_book["id"]}
			expect(ActiveBook.all.length).to eq(length_before_delete - 1)
		end

		it 'should render a json with key {token}' do
			@active_book.save
			length_before_delete = ActiveBook.all.length

			delete 'remove_active_book', params: {id: @active_book["id"]}
			expect(response_json).to include("token")
		end
	end
end
