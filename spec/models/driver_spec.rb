require 'rails_helper'

RSpec.describe Driver, type: :model do
  before :each do
    @driver1 = create(:driver)
    @driver2 = create(:driver)
  end
  it "has a valid factory" do
    expect(@driver1).to be_valid
  end
  
  it "is invalid without an email" do
    @driver1.email = nil
    expect(@driver1).to_not be_valid
  end

  it "is invalid with a duplicate email" do
    @driver2.email = @driver1.email
    expect(@driver2).to_not be_valid
  end

  it "is invalid without a password" do
    @driver1.password = nil
    expect(@driver1).to_not be_valid
  end
  
  it "is invalid with password length lower than 6 or greater than 20" do
    @driver1.password = "short"
    expect(@driver1).to_not be_valid
  end

  it "is valid with password length between 6 and 20" do
    @driver1.password = "validpass"
    expect(@driver1).to be_valid
  end

  it "is invalid without a full_name" do
    @driver1.full_name = nil
    expect(@driver1).to_not be_valid
  end

  it "is invalid with phone_number less than 11 or more than 13" do
    @driver1.phone_number = 1234567890
    expect(@driver1).to_not be_valid
  end

  it "is invalid without a license_plate" do
    @driver1.license_plate = nil
    expect(@driver1).to_not be_valid
  end

  it "is invalid without a license_number" do
    @driver1.license_number = nil
    expect(@driver1).to_not be_valid
  end

  it "is valid with license_number with exactly 12 digits" do
    @driver1.license_number = 123456789012
    expect(@driver1).to be_valid
  end

  it "is invalid without a ktp_number" do
    @driver1.ktp_number = nil
    expect(@driver1).to_not be_valid
  end

  it "is invalid without a address" do
    @driver1.address = nil
    expect(@driver1).to_not be_valid
  end

  # belom ditest associationnya
end
