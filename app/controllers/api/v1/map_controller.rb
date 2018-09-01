require_relative "../../../services/map_helper.rb"
require 'net/http'
require 'json'

class Api::V1::MapController < ApplicationController
  include MapHelper

  def get_price
    distance = params[:distance]

    begin
      render json: {
        price: calc_price(distance)
      }, status: :ok
    rescue Exception
      render err("Invalid parameters", :bad_request)
    end
  end

  def get_place_suggestions
    place_query = params[:query]
    region = params[:region]
    region ||= "id"

    url = URI.parse("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{place_query}&region=#{region}&location=-6.1753924,106.8271528&radius=50000&key=AIzaSyAPx6BKfp1WcSw2cxBwQnaOhObKFfeu-zw")
    result = Net::HTTP.get(url)
    result = JSON.parse(result)

    if result["status"] == 'OK'
      place_suggestions = result["results"].map do |place|
        {
          id: place["id"],
          name: place["name"],
          formatted_address: place["formatted_address"],
          lat: place["geometry"]["location"]["lat"],
          lng: place["geometry"]["location"]["lng"],
          types: place["types"]
        }
      end

      render json: {
        place_suggestions: place_suggestions
      }, status: :ok
    else
      render err("No data found", :bad_request)
    end
  end
end
