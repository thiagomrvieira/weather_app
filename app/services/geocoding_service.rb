require 'httparty'

class GeocodingService
  include HTTParty
  base_uri 'https://nominatim.openstreetmap.org'

  def get_coordinates(city)
    response = self.class.get('/search', query: { q: city, format: 'json', limit: 1 })
    return nil unless response.success?

    data = response.parsed_response.first
    return nil unless data

    {
      latitude: data['lat'],
      longitude: data['lon']
    }
  end
end
