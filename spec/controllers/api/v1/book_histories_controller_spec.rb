require 'rails_helper'

RSpec.describe Api::V1::BookHistoriesController, type: :controller do
  before :each do
    @member = create(:member)
    @driver = create(:driver)
    @pending_order_status = create(:order_status, status: "Pending", id: 1)
    @accepted_order_status = create(:order_status, status: "Accepted", id: 2)
    @pickedup_order_status = create(:order_status, status: "Picked Up", id: 3)

    @pending_book_histories = []
    5.times do
      @created_book_history = create(:book_history, member: @member, driver: @driver, order_status: @pending_order_status)
      @pending_book_histories << @created_book_history.as_json
    end

    @accepted_book_histories = []
    8.times do
      @created_book_history = create(:book_history, member: @member, driver: @driver, order_status: @accepted_order_status)
      @accepted_book_histories << @created_book_history.as_json
    end
  end

  describe '/GET member_histories' do
    before :each do |test|
      merge_header(auth_headers(@member.id,Rails.application.secrets.role_member)) unless test.metadata[:logged_out]
    end

    it "should respond with HTTP OK" do
      get 'member_histories', params: {member_id: @member.id}
      expect(response.status).to eq(200)
    end

    it "should return JSON with key {book_histories, token}" do
      get 'member_histories', params: {member_id: @member.id}
      expect(response_json).to include("book_histories", "token")
    end

    it "should return all member's book_histories" do
      get 'member_histories', params: {member_id: @member.id}
      expect(response_json["book_histories"].length).to eq(@pending_book_histories.length + @accepted_book_histories.length)
    end

    it "should return all book_histories with set order_status_id if parameter order_status_id is sent" do
      get 'member_histories', params: {member_id: @member.id, order_status_id: @pending_order_status.id}
      expect(response_json["book_histories"].length).to eq(@pending_book_histories.length)
    end

    it "should respond with HTTP BAD_REQUEST if parameter member_id is not sent" do
      get 'member_histories', params: {}
      expect(response.status).to eq(400)
    end
  end     

  describe '/PATCH update_rating' do
    before :each do |test|
      merge_header(auth_headers(@member.id,Rails.application.secrets.role_member)) unless test.metadata[:logged_out]
    end

    it 'should return HTTP OK' do
      patch 'update_rating', params: {id: @pending_book_histories[0]["id"], rating: 5}
      expect(response.status).to eq(200)
    end

    it "should return a token" do
      patch 'update_rating', params: {id: @pending_book_histories[0]["id"], rating: 5}
      expect(response_json).to include("token")
    end
  end
end