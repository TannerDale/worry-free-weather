class OpenWeatherService
  class << self
    def weather_data(coords)
      response = OpenWeatherClient.fetch(url(coords))

      formatted_response(response)
    end

    private

    def formatted_response(response)
      {
        current: filter_current(response[:current]),
        hourly: filter_hourly(response[:hourly]),
        daily: filter_daily(response[:daily])
      }
    end

    def url(coords)
      "/data/2.5/onecall?#{format_coords(coords)}"
    end

    def format_coords(coords)
      coords.map do |key, value|
        "#{key}=#{value}"
      end.join('&')
    end

    def filter_current(current)
      {
        dt: current[:dt],
        sunrise: current[:sunrise],
        sunset: current[:sunset],
        temp: current[:temp],
        feels_like: current[:feels_like],
        humidity: current[:humidity],
        uvi: current[:uvi],
        visibility: current[:visibility],
        description: current[:weather].first[:description],
        icon: current[:weather].first[:icon]
      }
    end

    def filter_hourly(hourly)
      hourly[..7].map do |hour|
        hour_data(hour)
      end
    end

    def filter_daily(daily)
      daily[..4].map do |day|
        day_data(day)
      end
    end

    def hour_data(hour)
      {
        dt: hour[:dt],
        temp: hour[:temp],
        description: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon]
      }
    end

    def day_data(day)
      {
        dt: day[:dt],
        sunrise: day[:sunrise],
        sunset: day[:sunset],
        min_temp: day[:temp][:min],
        max_temp: day[:temp][:max],
        description: day[:weather].first[:description],
        icon: day[:weather].first[:icon]
      }
    end
  end
end
