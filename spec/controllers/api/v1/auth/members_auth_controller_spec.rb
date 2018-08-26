require 'rails_helper'
require_relative '../../../../../app/services/json_web_token.rb'

RSpec.describe Api::V1::Auth::MembersAuthController, type: :controller do
  before :each do
    @member = create(:member)
    @member2 = build(:member)
  end

  describe "/POST Login" do
    it "returns HTTP 401 (unauthorized) on unsuccessful login" do
      post 'login'
      expect(response.status).to eq(401)
    end

    it "returns HTTP 201 (created) on successful login" do 
      post 'login', params: {email: @member.email, password: @member.password}
      expect(response.status).to eq(201)
    end

    it "returns a valid token on successful login" do
      post 'login', params: {email: @member.email, password: @member.password}
      token = response_json["token"]["access_token"]
      token_compare = JsonWebToken.generate_token({id: @member.id, role: Rails.application.secrets.role_member})[:access_token]
      expect(token).to eq(token_compare)
    end
  end

  describe "/POST register" do
    it "returns HTTP 201 (created) on successful registration" do
      post 'register', params: {
        email: @member2.email,
        password: @member2.password,
        full_name: @member2.full_name,
        phone_number: @member2.phone_number}
      expect(response.status).to eq(201)
    end

    it "returns email and id on success" do 
      post 'register', params: {
        email: @member2.email,
        password: @member2.password,
        full_name: @member2.full_name,
        phone_number: @member2.phone_number}
      member = response_json["member"]
      expect(member).to include("email", "id")
    end

    it "returns HTTP 201 and a token on successful registration" do 
      post 'register', params: {
        email: @member2.email,
        password: @member2.password,
        full_name: @member2.full_name,
        phone_number: @member2.phone_number}
      expect(response_json).to include("token")
      
      token = response_json["token"]["access_token"]
      token_compare = JsonWebToken.generate_token({id: response_json["member"]["id"], role: Rails.application.secrets.role_member})[:access_token]
    end

    it "returns HTTP 400 and message registration failed" do
      post 'register', params: {email: @member2.email, password: @member2.password}
      expect(response.status).to eq(400)
    end
  end
end
