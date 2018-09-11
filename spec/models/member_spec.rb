require 'rails_helper'

RSpec.describe Member, type: :model do
  before :each do
    @member1 = create(:member)
    @member2 = create(:member)
    @member3 = create(:member)
  end
  it "has a valid factory" do
    expect(@member1).to be_valid
  end
  
  it "is invalid without an email" do
    @member1.email = nil
    expect(@member1).to_not be_valid
  end

  it "is invalid with a duplicate email" do
    @member2.email = @member1.email
    expect(@member2).to_not be_valid
  end

  # it "is invalid without a password" do
  #   @member1.password = nil
  #   expect(@member1).to_not be_valid
  # end

  # it "is invalid with password length lower than 6 or greater than 20" do
  #   @member1.password = "short"
  #   expect(@member1).to_not be_valid
  # end

  # it "is valid with password length between 6 and 20" do
  #   @member1.password = "validpass"
  #   expect(@member1).to be_valid
  # end

  it "is invalid without a full_name" do
    @member1.full_name = nil
    expect(@member1).to_not be_valid
  end

  it "is invalid without a phone_number" do
    @member1.phone_number = nil
    expect(@member1).to_not be_valid
  end

  it "is valid with phone_number between 11 and 13 digits" do
    @member1.phone_number = 12345678901
    expect(@member1).to be_valid
  end

  # belom ditest associationnya
end
