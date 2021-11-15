class ActivitySerializer
  def self.serialize(data)
    {
      data: {
        id: nil,
        type: 'activities',
        attributes: data
      }
    }.to_json
  end
end
