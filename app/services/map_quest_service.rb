class MapQuestService
  class << self
    def location_lat_lon(location)
      filter_data(MapQuestClient.fetch(url(location)))
    end

    private

    def url(location)
      "/geocoding/v1/address?location=#{location}"
    end

    def filter_data(data)
      data[:results].first[:locations].first[:latLng]
    end
  end
end
