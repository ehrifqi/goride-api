require 'rails_helper'

RSpec.describe Api::V1::DriverDetailsController, type: :controller do
 before :each do
 	@driver = create(:driver)
 	@driver_detail = create(:driver_detail, driver_id: @driver)
 end

 describe '/GET show' do
    before :each do |test|
  	  merge_header(auth_headers(@driver.id,Rails.application.secrets.role_driver)) unless test.metadata[:logged_out]
    end
    
    it 'should return HTTP OK' do
      get 'show', params: {id: @driver_detail.id}
      expect(response.status).to eq(200)
    end

    it 'should return JSON with key {driver_detail, token}' do
        get 'show', params: {id: @driver_detail.id}
        expect(response_json).to include("driver_detail", "token")
    end

    it 'should return the correct driver_detail' do
      get 'show', params: {id: @driver_detail.id}
      driver_detail = response_json["driver_detail"]
      expect(driver_detail["driver_id"]).to eq(@driver_detail.driver_id)
    end
  end
end
