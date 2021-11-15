class ImageSerializer
  def self.serialize(data)
    {
      data: {
        id: nil,
        type: 'image',
        attributes: {
          image_url: data[:url],
          author_name: data[:author]
        }
      }
    }.to_json
  end
end
