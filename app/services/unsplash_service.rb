class UnsplashService
  class ImageNotFound < StandardError; end

  class << self
    def location_image(city)
      result = UnsplashClient.fetch(url(city))

      raise ImageNotFound if result[:results].empty?

      format_data(result)
    end

    private

    def url(city)
      "/search/photos?query=#{city}"
    end

    def format_data(data)
      {
        url: data[:results].first[:urls][:regular],
        author: data[:results].first[:user][:name]
      }
    end
  end
end
