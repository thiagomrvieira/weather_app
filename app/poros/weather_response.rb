class WeatherResponse
  attr_reader :latitude, :longitude, :generationtime_ms, :utc_offset_seconds,
              :timezone, :timezone_abbreviation, :elevation, :current_weather_units,
              :current_weather, :city

  def initialize(data)
    @latitude = data['latitude']
    @longitude = data['longitude']
    @generationtime_ms = data['generationtime_ms']
    @utc_offset_seconds = data['utc_offset_seconds']
    @timezone = data['timezone']
    @timezone_abbreviation = data['timezone_abbreviation']
    @elevation = data['elevation']
    @current_weather_units = data['current_weather_units']
    @current_weather = data['current_weather']
    @city = data['city']
  end

  def as_json(_options = {})
    {
      city: @city,
      location: "#{@latitude}, #{@longitude}",
      generation_time: "#{@generationtime_ms} ms",
      utc_offset: "#{@utc_offset_seconds} seconds",
      timezone: "#{@timezone} (#{@timezone_abbreviation})",
      elevation: "#{@elevation} meters",
      current_weather: format_current_weather
    }
  end

  private

  def format_current_weather
    {
      time: format_time(@current_weather['time']),
      temperature: "#{@current_weather['temperature']} #{@current_weather_units['temperature']}",
      windspeed: "#{@current_weather['windspeed']} #{@current_weather_units['windspeed']}",
      winddirection: "#{@current_weather['winddirection']} #{@current_weather_units['winddirection']}",
      period: @current_weather['is_day'] == 1 ? 'Day' : 'Night',
      weathercode: "WMO Code #{@current_weather['weathercode']}"
    }
  end

  def format_time(time_string)
    Time.parse(time_string).strftime('%d/%m/%Y %H:%M')
  end
end
