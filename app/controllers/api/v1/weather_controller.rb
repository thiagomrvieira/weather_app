class Api::V1::WeatherController < ApplicationController
  def show
    city = params[:city]
    geocoding_service = GeocodingService.new
    weather_service = WeatherService.new(geocoding_service)
    response = weather_service.current_weather(city)

    if response && response.success?
      render json: response
    else
      render json: { error: 'Unable to fetch weather data' }, status: :unprocessable_entity
    end
  end
end