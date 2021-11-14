class ForecastFacade
  class << self
    def weather_data(city)
      ForecastSerializer.serialize(raw_weather_data(city))
    end

    private

    def raw_weather_data(city)
      OpenWeatherService.weather_data(city_coords(city))
    end

    def city_coords(city)
      MapQuestService.location_lat_lon(city)
    end
  end
end
