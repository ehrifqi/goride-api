require 'rails_helper'

RSpec.describe MemberDetail, type: :model do
   before :each do
    @member_detail1 = create(:member_detail)
    @member_detail2 = create(:member_detail)
  end

  it "has a valid factory" do
    expect(@member_detail1).to be_valid
  end
end
