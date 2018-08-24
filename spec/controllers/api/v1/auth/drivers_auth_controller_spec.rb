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
  end
end