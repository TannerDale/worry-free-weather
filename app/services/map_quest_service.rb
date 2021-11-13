class MapQuestService
  class << self
    def location_lat_lng(location)
      filter_data(MapQuestClient.fetch(location))
    end

    private

    def filter_data(data)
      data[:results].first[:locations].first[:latLng]
    end
  end
end
