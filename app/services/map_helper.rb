require_relative "./converter.rb"
require 'rubygems'

module MapHelper
  PRICE_PER_KM = 2000
  GO_PAY_MULTIPLIER = 0.95

  def calc_price(distance_in_km)
    begin
      ((distance_in_km.to_f * PRICE_PER_KM).ceil / 1000).ceil * 1000
    rescue

    end
  end

  def calc_price_with_gopay(distance_in_km)
    begin
      (((distance_in_km.to_f * PRICE_PER_KM).ceil * GO_PAY_MULTIPLIER).ceil / 1000).ceil * 1000
    rescue

    end
  end
end