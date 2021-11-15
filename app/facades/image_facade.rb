class ImageFacade
  class << self
    def location_image(city)
      ImageSerializer.serialize(image_data(city))
    end

    private

    def image_data(city)
      UnsplashService.location_image(city)
    end
  end
end
