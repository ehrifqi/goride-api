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

  it "is invalid without a password" do
    @member1.password = nil
    expect(@member1).to_not be_valid
  end

  it "is valid with a username" do
    expect(@member1).to be_valid
  end

  it "is valid with no username" do
    @member1.username = nil
    @member2.username = ""
    expect(@member1).to be_valid
    expect(@member2).to be_valid
  end

  it "is invalid with a username with length greater than 30" do
    @member1.username = "toolongusernamethismustwillnotpass"
    expect(@member1).to_not be_valid
  end

  it "is invalid with password length lower than 6 or greater than 20" do
    @member1.password = "short"
    expect(@member1).to_not be_valid
  end

  it "is valid with password length between 6 and 20" do
    @member1.password = "validpass"
    expect(@member1).to be_valid
  end
end
