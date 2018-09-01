require 'rails_helper'

RSpec.describe Api::V1::MapController, type: :controller do
  describe "/GET get_price" do
    it "returns HTTP 200 on successful call" do
      get 'get_price'
      expect(response.status).to eq(200)
    end

    it "returns price on successful call" do
      get 'get_price'
      expect(response_json).to include("price")
    end
  end
end
