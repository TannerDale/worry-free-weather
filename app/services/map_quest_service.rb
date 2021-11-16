class MapQuestService
  class ImpossibleRoute < StandardError; end

  class << self
    def location_lat_lon(location)
      filter_geocoding_data(MapQuestClient.fetch(geocoding_url(location)))
    end

    def road_trip(to, from)
      route = MapQuestClient.fetch(road_trip_url(to, from))

      raise ImpossibleRoute if route[:info][:statuscode] == 402

      filter_road_trip_data(route)
    end

    private

    def geocoding_url(location)
      "/geocoding/v1/address?location=#{location}"
    end

    def filter_geocoding_data(data)
      data[:results].first[:locations].first[:latLng]
    end

    def road_trip_url(to, from)
      "/directions/v2/route?to=#{to}&from=#{from}&units=m"
    end

    def filter_road_trip_data(data)
      {
        time: data[:route][:time],
        destination_coords: data[:route][:boundingBox][:ul]
      }
    end
  end
end
