class RoadTripFacade
  class << self
    def road_trip(to, from)
      route = route_info(to, from)

      format_road_trip(to, from, route)
    rescue MapQuestService::ImpossibleRoute
      format_road_trip(to, from, { time: 'impossible', weather: {} })
    end

    private

    def format_road_trip(to, from, route)
      {
        start_city: from,
        end_city: to,
        travel_time: route[:time],
        weather_at_eta: route[:weather]
      }
    end

    def route_info(to, from)
      route = MapQuestService.road_trip(to, from)
      time = travel_time(route[:time])
      weather = weather_at_arrival(route[:destination_coords], time[:hours])

      {
        time: "#{time[:hours]} hours, #{time[:minutes]} minutes",
        weather: weather
      }
    end

    def travel_time(time)
      total_minutes = time / 60
      {
        hours: total_minutes / 60,
        minutes: total_minutes % 60
      }
    end

    def weather_at_arrival(coords, hours)
      all_weather = OpenWeatherService.one_call_response(coords)

      temp_and_description(all_weather, hours)
    end

    def temp_and_description(weather, hours)
      hour_weather = weather[:hourly][hours - 1]

      {
        temperature: hour_weather[:temp],
        conditions: hour_weather[:weather].first[:description]
      }
    end
  end
end
