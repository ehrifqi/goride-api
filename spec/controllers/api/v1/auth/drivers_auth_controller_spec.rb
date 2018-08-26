require 'rails_helper'
require_relative '../../../../../app/services/json_web_token.rb'

RSpec.describe Api::V1::Auth::DriversAuthController, type: :controller do
  before :each do
    @driver = create(:driver)
    @driver2 = build(:driver)
  end

  describe "/POST login" do
    it "returns HTTP 401 (unauthorized) on unsuccessful login" do
      post 'login'
      expect(response.status).to eq(401)
  	end

  	it "returns HTTP 201 (created) on successful login" do 
      post 'login', params: {email: @driver.email, password: @driver.password}
      expect(response.status).to eq(201)
  	end

  	it "returns a valid token on successful login" do
      post 'login', params: {email: @driver.email, password: @driver.password}
      token = response_json["token"]["access_token"]
      token_compare = JsonWebToken.generate_token({id: @driver.id, role: Rails.application.secrets.role_driver})[:access_token]
      expect(token).to eq(token_compare)
  	end
  end

  describe "/POST register" do
    it "returns HTTP 201 (created) on successful registration" do 
      post 'register', params: {
        email: @driver2.email, 
        password: @driver2.password,
        full_name: @driver2.full_name,
        birthdate: @driver2.birthdate,
        phone_number: @driver2.phone_number,
        license_plate: @driver2.license_plate,
        license_number: @driver2.license_number,
        ktp_number: @driver2.ktp_number,
        address: @driver2.address}
      expect(response.status).to eq(201)
    end

    it "returns email and id on success" do 
      post 'register', params: {
        email: @driver2.email, 
        password: @driver2.password,
        full_name: @driver2.full_name,
        birthdate: @driver2.birthdate,
        phone_number: @driver2.phone_number,
        license_plate: @driver2.license_plate,
        license_number: @driver2.license_number,
        ktp_number: @driver2.ktp_number,
        address: @driver2.address}
      driver = response_json["driver"]
      expect(driver).to include("email", "id")
    end

    it "returns HTTP 201 and a token on successful registration" do 
      post 'register', params: {
        email: @driver2.email, 
        password: @driver2.password,
        full_name: @driver2.full_name,
        birthdate: @driver2.birthdate,
        phone_number: @driver2.phone_number,
        license_plate: @driver2.license_plate,
        license_number: @driver2.license_number,
        ktp_number: @driver2.ktp_number,
        address: @driver2.address}
      expect(response_json).to include("token")
      
      token = response_json["token"]["access_token"]
      token_compare = JsonWebToken.generate_token({id: response_json["driver"]["id"], role: Rails.application.secrets.role_driver})[:access_token]
    end
    
    it "returns HTTP 400 and message registration failed" do 
      post 'register', params: {email: @driver2.email, password: @driver2.password}
      expect(response.status).to eq(400)
      expect(response_json).to include("message")
  	end
  end
end