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
end
