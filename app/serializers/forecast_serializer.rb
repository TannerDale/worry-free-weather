class ForecastSerializer
  def self.serialize(weather_data)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: weather_data
      }
    }.to_json
  end
end
