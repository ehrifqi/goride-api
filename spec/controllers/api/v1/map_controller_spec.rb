require 'rails_helper'

RSpec.describe Api::V1::MapController, type: :controller do
  describe "/GET get_price" do
    it "returns HTTP 200 on successful call" do
      get 'get_price'
      expect(response.status).to eq(200)
    end

    it "returns price and price_with_gopay on successful call" do
      get 'get_price'
      expect(response_json).to include("price", "price_with_gopay")
    end
  end

  describe "/GET get_place_suggestions" do
    it "returns HTTP 200 on successful call" do
      get 'get_place_suggestions', params: {query: "central park"}
      expect(response.status).to eq(200)
    end

    it "returns json with key \"place_suggestions\"" do
      get 'get_place_suggestions', params: {query: "central park"}
      expect(response_json).to include("place_suggestions")
    end

    it "returns json with keys: [place_suggestions][name, id, formatted_address, lat, lng]" do
      get 'get_place_suggestions', params: {query: "central park"}
      expect(response_json["place_suggestions"][0]).to include("name", "id", "formatted_address", "lat", "lng")
    end

    it "returns HTTP 400 and a message without query parameter" do
      get 'get_place_suggestions', params: {query: nil}
      expect(response.status).to eq(400)
      expect(response_json).to include("message")
    end
  end
end
