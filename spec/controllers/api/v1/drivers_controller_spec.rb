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

  describe '/PATCH update' do
    before :each do |test|
      merge_header(auth_headers(@driver.id,Rails.application.secrets.role_driver)) unless test.metadata[:logged_out]
    end

    it 'should return HTTP OK' do
      patch 'update', params: {
        id: @driver.id,
        email: @driver.email,
        password: @driver.password,
        full_name: "Mamat Kerok",
        birthdate: "12-12-1990",
        license_plate: "B 123 HAH",
        rating: 3,
        phone_number: "087667801672",
        license_number: "109827361092",
        ktp_number: "1982530723917401",
        address: "Jalan Menceng Raya 5",
        income: 12000
      }
      expect(response.status).to eq(200)
    end

    it 'should return JSON with key {driver, token}' do
      patch 'update', params: {
        id: @driver.id,
        email: @driver.email,
        password: @driver.password,
        full_name: "Mamat Kerok",
        birthdate: "12-12-1990",
        license_plate: "B 123 HAH",
        rating: 3,
        phone_number: "087667801672",
        license_number: "109827361092",
        ktp_number: "1982530723917401",
        address: "Jalan Menceng Raya 5",
        income: 12000
      }
      expect(response_json).to include("driver", "token")
    end

    it 'should update new data with the correct id' do
      patch 'update', params: {
        id: @driver.id,
        email: @driver.email,
        password: @driver.password,
        full_name: "Mamat Kerok",
        birthdate: "12-12-1990",
        license_plate: "B 123 HAH",
        rating: 3.2,
        phone_number: "087667801672",
        license_number: "109827361092",
        ktp_number: "1982530723917401",
        address: "Jalan Menceng Raya 5",
        income: 12000
      }
      driver = response_json["driver"]
      expect(driver["id"]).to eq(@driver.id)
      expect(driver["full_name"]).to eq("Mamat Kerok")
      expect(driver["birthdate"]).to eq("1990-12-12T00:00:00.000Z")
      expect(driver["license_plate"]).to eq("B 123 HAH")
      expect(driver["phone_number"]).to eq("087667801672")
      expect(driver["license_number"]).to eq("109827361092")
      expect(driver["ktp_number"]).to eq("1982530723917401")
      expect(driver["address"]).to eq("Jalan Menceng Raya 5")
    end
  end
end
