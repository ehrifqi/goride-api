require_relative "./converter.rb"
require 'rubygems'

module MapHelper
  def calc_price(distance_in_km)
    begin
      distance_in_km.to_f * 2000
    rescue

    end
  end
end