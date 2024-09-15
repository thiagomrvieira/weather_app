# Weather Forecast API
This application provides weather data using a clean and modular Ruby on Rails architecture. Below you'll find all the details to undertand all the implementation details and how to use the application.

### 📋 Overview

This project integrates with external APIs to fetch weather data based on city names. The data is processed and presented in a user-friendly format. Here’s a high-level overview of what’s included:

* **Weather Data Fetching** : Retrieves current weather data using the Open Meteo API.
* **Geocoding**: Converts city names to geographic coordinates.
* **Error Handling**: Robust error handling and logging mechanisms.

###  🔍 Services
#### Weather Fetching Service
* `FetchWeather`: Service Object that validates city input and fetches weather data.
* `WeatherService`: Handles the interaction with the weather API and caching.
#### Error Handling
* Logs errors and unexpected issues for debugging.
* Provides meaningful error messages to users.

###  📜 Logging
All important actions and errors are logged using Rails’ logger. This includes:

* Cache hits and misses
* Data fetching status
* Error messages

###  🎨 Code Organization
#### Service Objects
* FetchWeather: Manages the overall process of fetching weather data.
* WeatherService: Encapsulates the logic for calling the weather API and caching responses.

### POROs
`WeatherResponse`: Transforms raw API data into a more user-friendly format.

### Error Handling
Custom `error handlingà is implemented to provide clear and actionable feedback.

### 🚀 Running the project
#### Ruby Version
Ensure you have Ruby 3.1.0 or higher installed.

#### System Dependencies
* Rails: 7.0.x
* HTTParty: For making HTTP requests.
* ActiveSupport: For utility methods and other Rails functionalities.

#### Configuration
1- Clone the repository:
```bash
  git clone https://github.com/thiagomrvieira/weather_app

  cd weather_app
```
2- Install dependencies:
```bash
  bundle install
```
#### Running the Application
```bash
  rails s
```
Visit http://127.0.0.1:3000/api/v1/weather?city=London in your browser or use a tool like Postman to test the API endpoints.




