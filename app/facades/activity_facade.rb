class ActivityFacade
  class << self
    def activities(city)
      weather = current_weather(city)

      ActivitySerializer.serialize(format_activities_info(city, weather))
    end

    private

    def format_activities_info(city, weather)
      {
        destination: city,
        forecast: {
          summary: weather[:summary],
          temperature: "#{weather[:temp].to_i} F"
        },
        activities: activities_info(weather[:temp])
      }
    end

    def activities_info(temp)
      activity_types(temp).map do |act|
        BoredService.activity(act)
      end
    end

    def activity_types(temp)
      ['relaxation', second_activity(temp)]
    end

    def second_activity(temp)
      if temp >= 60
        'recreational'
      elsif temp >= 50
        'busywork'
      else
        'cooking'
      end
    end

    def current_weather(city)
      OpenWeatherService.current_weather_data(coords(city))
    end

    def coords(city)
      MapQuestService.location_lat_lon(city)
    end
  end
end
