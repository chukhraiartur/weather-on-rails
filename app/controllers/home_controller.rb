# frozen_string_literal: true

require 'uri'
require 'net/http'

class HomeController < ApplicationController
  def index
    url = "https://api.openweathermap.org/data/2.5/weather?lat=51.5072&lon=0.1276&appid=e30e1124a1c82c45093e3a79d883c4c0&units=metric"
    
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    
    @data = JSON.parse(response.body)
  end
end