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

    response = self.class.get('', query: { latitude: coordinates[:latitude], longitude: coordinates[:longitude], current_weather: true })
    raise "Weather API failed: #{response.code}" unless response.success?

    response
  rescue => e
    Rails.logger.error(e.message)
    nil
  end

end
