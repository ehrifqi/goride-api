require_relative "./converter.rb"
require 'rubygems'

module MapHelper
  PRICE_PER_KM = 2000
  GO_PAY_MULTIPLIER = 0.95

  def calc_price(distance_in_km)
    begin
      ceil(distance_in_km.to_f * PRICE_PER_KM)
    rescue

    end
  end

  def calc_price_with_gopay(distance_in_km)
    begin
      ceil((distance_in_km.to_f * PRICE_PER_KM)*GO_PAY_MULTIPLIER)
    rescue

    end
  end
end