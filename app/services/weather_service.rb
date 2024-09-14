require 'httparty'

class WeatherService
  include HTTParty
  base_uri 'https://api.open-meteo.com/v1/forecast'

  def initialize(geocoding_service)
    @geocoding_service = geocoding_service
  end

  def current_weather(city)
    Rails.logger.info("Checking cache for weather data for city: #{city}")

    Rails.cache.fetch("weather_#{city}", expires_in: 30.minutes) do
      Rails.logger.info("Cache miss for city: #{city}. Fetching new data...")

      coordinates = @geocoding_service.get_coordinates(city)
      return nil unless coordinates

      response = fetch_weather_data(coordinates)

      if response.success?
        Rails.logger.info("Successfully fetched new weather data for city: #{city}")
        response
      else
        Rails.logger.error("Failed to fetch weather data for city: #{city}")
        nil
      end
    end

  rescue StandardError => e
    Rails.logger.error("Error in WeatherService: #{e.message}")
    nil
  end

  private

  def fetch_weather_data(coordinates)
    self.class.get('', query: {
      latitude: coordinates[:latitude],
      longitude: coordinates[:longitude],
      current_weather: true
    })
  end
end
