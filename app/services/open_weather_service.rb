class OpenWeatherService
  class << self
    def weather_data(coords)
      response = OpenWeatherClient.fetch(url(coords))

      formatted_response(response)
    end

    private

    def url(coords)
      "/data/2.5/onecall?#{format_coords(coords)}"
    end

    def format_coords(coords)
      "lat=#{coords[:lat]}&lon=#{coords[:lng]}"
    end

    def formatted_response(response)
      {
        current_weather: filter_current(response[:current]),
        hourly_weather: filter_hourly(response[:hourly]),
        daily_weather: filter_daily(response[:daily])
      }
    end

    def filter_current(current)
      {
        datetime: format_datetime(current[:dt]),
        sunrise: format_datetime(current[:sunrise]),
        sunset: format_datetime(current[:sunset]),
        temp: current[:temp],
        feels_like: current[:feels_like],
        humidity: current[:humidity],
        uvi: current[:uvi],
        visibility: current[:visibility],
        conditions: current[:weather].first[:description],
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
        time: format_time(hour[:dt]),
        temp: hour[:temp],
        conditions: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon]
      }
    end

    def day_data(day)
      {
        date: format_date(day[:dt]),
        sunrise: format_datetime(day[:sunrise]),
        sunset: format_datetime(day[:sunset]),
        min_temp: day[:temp][:min],
        max_temp: day[:temp][:max],
        conditions: day[:weather].first[:description],
        icon: day[:weather].first[:icon]
      }
    end

    def format_datetime(datetime)
      Time.at(datetime).to_s
    end

    def format_time(time)
      Time.at(time).strftime('%H:%M:%S')
    end

    def format_date(date)
      Time.at(date).strftime('%Y-%m-%d')
    end
  end
end
