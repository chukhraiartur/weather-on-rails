# frozen_string_literal: true

require 'uri'
require 'net/http'

class HomeController < ApplicationController
  def index
    if params[:city].present? 
      results = Geocoder.search(params[:city])

      if results.any?
        name = results.first.city
        latitude = results.first.latitude
        longitude = results.first.longitude

        url = "https://api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}6&appid=e30e1124a1c82c45093e3a79d883c4c0&units=metric"
        response = Net::HTTP.get_response(URI(url))
        data = JSON.parse(response.body)
        
        existing_city = City.find_by(name: name)

        if existing_city.nil?
          City.create(
            name: name,
            latitude: latitude,
            longitude: longitude,
            data: data,
            date: Date.today.strftime("%A, %B %d")
          )
        else
          existing_city.update(
            latitude: latitude,
            longitude: longitude,
            data: data,
            date: Date.today.strftime("%A, %B %d")
          )
          flash[:notice] = "City '#{name}' data updated in the database."
        end
      end
    end

    @cities = City.all || []
  end

  def clear_results
    City.destroy_all
    redirect_to root_path
  end
end