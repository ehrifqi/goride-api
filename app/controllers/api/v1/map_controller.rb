require_relative "../../../services/map_helper.rb"

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
end
