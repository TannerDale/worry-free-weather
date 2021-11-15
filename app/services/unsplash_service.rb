class UnsplashService
  class << self
    def location_image(city)
      format_data(UnsplashClient.fetch(url(city)))
    end

    private

    def url(city)
      "/search/photos?query=#{city}"
    end

    def format_data(data)
      {
        url: data[:results].first[:urls][:regular],
        author: data[:results].first[:user][:name],
      }
    end
  end
end
