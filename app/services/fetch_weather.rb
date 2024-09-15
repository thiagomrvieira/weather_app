class FetchWeather
  def initialize(city)
    @city = city
  end

  def call
    validate_city!
    weather_service = WeatherService.new(GeocodingService.new)
    weather_data = weather_service.current_weather(@city)
    weather_data['city'] = @city if weather_data

    WeatherResponse.new(weather_data)
  end

  private

  def validate_city!
    @city.strip!
    raise ArgumentError, 'City cannot be blank' if @city.blank?
    raise ArgumentError, 'City name is too short' if @city.length < 2
    raise ArgumentError, 'City name is too long' if @city.length > 100
    raise ArgumentError, 'City name is invalid' unless @city.match?(/\A[a-zA-Z\s]+\z/)
    raise ArgumentError, 'City name must be UTF-8 encoded' unless @city.valid_encoding?
  end
end