class ForecastFacade
  class << self
    def weather_data(city)
      OpenWeatherService.weather_data(city_coords(city))
    end

    private

    def city_coords(city)
      MapQuestService.location_lat_lng(city)
    end
  end
end
