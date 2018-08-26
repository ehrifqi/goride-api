require 'rails_helper'
require_relative '../../../../../app/services/json_web_token.rb'

RSpec.describe Api::V1::Auth::DriversAuthController, type: :controller do
  before :each do
    @driver = create(:driver, email: "gojek@gojek.com", password: "gojekgojek")
  end

  describe "valid token generation" do
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

    it "returns HTTP 400 (bad_request) on unsuccessful register" do
      post 'register', params: {email: @driver.email, password: @driver.password, full_name: "Mamang Modip",
            birthdate: "26-08-1990",license_plate: "B 123 YOI", phone_number: "123456789012", license_number: "123456789012",
            ktp_number: "1234567890123456",address: "Syahdan 1"}
      expect(response.status).to eq(400)
    end

    it "returns a valid token on successful register" do
      post 'register', params: {email: "driver@driver.com", password: "driverdriver", full_name: "Mamang Modip",
            birthdate: "26-08-1990",license_plate: "B 123 YOI", phone_number: "123456789012", license_number: "123456789012",
            ktp_number: "1234567890123456",address: "Syahdan 1"}
      expect(response.status).to eq(201)
    end

    it "returns a valid token on successful register" do
      post 'register', params: {email: "driver@driver.com", password: "driverdriver", full_name: "Mamang Modip",
            birthdate: "26-08-1990",license_plate: "B 123 YOI", phone_number: "123456789012", license_number: "123456789012",
            ktp_number: "1234567890123456",address: "Syahdan 1"}
      token = response_json["token"]["access_token"]
      token_compare = JsonWebToken.generate_token({id: 2, role: Rails.application.secrets.role_driver})[:access_token]
      expect(token).to eq(token_compare)
    end
  end
end