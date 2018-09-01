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
  end
end
