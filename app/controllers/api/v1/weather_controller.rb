class Api::V1::WeatherController < ApplicationController
  def show
    city = params[:city]
    weather_data = fetch_weather_data(city)

    return render_success(weather_data) if weather_data

    render_error('Unable to fetch weather data, please check city name or try again later.', :unprocessable_entity)
  rescue ArgumentError => e
    render_error(e.message, :bad_request)
  rescue StandardError => e
    handle_unexpected_error(e)
  end

  private

  def fetch_weather_data(city)
    FetchWeather.new(city).call
  end

  def render_success(data)
    render json: data
  end

  def render_error(message, status)
    render json: { error: message }, status: status
  end

  def handle_unexpected_error(error)
    Rails.logger.error("Error fetching weather data: #{error.message}")
    render_error('An unexpected error occurred', :internal_server_error)
  end
end
