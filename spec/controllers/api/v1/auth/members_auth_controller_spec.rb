require 'rails_helper'
require_relative '../../../../../app/services/json_web_token.rb'

RSpec.describe Api::V1::Auth::MembersAuthController, type: :controller do
  before :each do
    @member = create(:member, email: "gojek@gojek.com", password: "gojekgojek")
  end
  describe "valid token generation" do
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
end
