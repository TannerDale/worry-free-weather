class RoadTripSerializer
  def self.serialize(data)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: data
      }
    }.to_json
  end
end
