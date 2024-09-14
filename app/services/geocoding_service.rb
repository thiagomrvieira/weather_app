require 'httparty'

class GeocodingService
  include HTTParty
  base_uri 'https://nominatim.openstreetmap.org'
  headers 'User-Agent' => 'WeatherApp (thiagomrvieira@gmail.com)'

  def get_coordinates(city)
    response = self.class.get('/search', query: { q: city, format: 'json', limit: 1 })
    raise "Geocoding API failed: #{response.code}" unless response.success?

    data = response.parsed_response.first
    raise "No geocoding data found for city: #{city}" unless data

    {
      latitude: data['lat'],
      longitude: data['lon']
    }
  rescue => e
    Rails.logger.error(e.message)
    nil
  end

end
