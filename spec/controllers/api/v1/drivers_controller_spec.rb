require 'rails_helper'

RSpec.describe Api::V1::DriversController, type: :controller do
  before :each do
    @driver = create(:driver)
  end

  describe '/GET show' do
    before :each do |test|
  	  merge_header(auth_headers(@driver.id,Rails.application.secrets.role_driver)) unless test.metadata[:logged_out]
    end
    
    it 'should return HTTP OK' do
      get 'show', params: {id: @driver.id}
      expect(response.status).to eq(200)
    end

    it 'should return JSON with key {driver, token}' do
        get 'show', params: {id: @driver.id}
        expect(response_json).to include("driver", "token")
    end

    it 'should return the correct driver' do
      get 'show', params: {id: @driver.id}
      driver = response_json["driver"]
      expect(driver["email"]).to eq(@driver.email)
      expect(driver["full_name"]).to eq(@driver.full_name)
      expect(driver["phone_number"]).to eq(@driver.phone_number)
    end
  end
end
