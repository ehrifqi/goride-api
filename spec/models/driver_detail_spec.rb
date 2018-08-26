require 'rails_helper'

RSpec.describe DriverDetail, type: :model do
  before :each do
    @driver_detail1 = create(:driver_detail)
    @driver_detail2 = create(:driver_detail)
  end

  it "has a valid factory" do
    expect(@driver_detail1).to be_valid
  end

  it "is valid if return true or false" do
  	expect(@driver_detail1).to be_valid
  end
end
