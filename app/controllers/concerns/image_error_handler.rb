module ImageErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from UnsplashService::ImageNotFound do
      render json: {
        data: {
          message: 'No Image Found'
        }
      }, status: 200
    end
  end
end
