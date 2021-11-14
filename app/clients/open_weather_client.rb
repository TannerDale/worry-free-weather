class OpenWeatherClient
  class << self
    def fetch(url)
      parse_data(conn.get(url))
    end

    private

    def conn
      Faraday.new(
        url: 'https://api.openweathermap.org',
        params: {
          appid: ENV['open_weather_api_key'],
          exclude: 'minutely,alerts',
          units: 'imperial'
        }
      )
    end

    def parse_data(response)
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
