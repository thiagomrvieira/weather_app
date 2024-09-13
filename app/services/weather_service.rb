require 'httparty'

class WeatherService
  include HTTParty
  base_uri 'https://api.open-meteo.com/v1/forecast'

  def initialize(geocoding_service)
    @geocoding_service = geocoding_service
  end

  def current_weather(city)
    coordinates = @geocoding_service.get_coordinates(city)
    return nil unless coordinates

    self.class.get('', query: { latitude: coordinates[:latitude], longitude: coordinates[:longitude], current_weather: true })
  end
end
