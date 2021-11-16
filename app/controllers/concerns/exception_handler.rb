module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::BadRequest do |e|
      render json: {
        message: 'Invalid Request',
        error: { details: e.message }
      }, status: 400
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: {
        message: 'Invalid Record',
        error: { details: e.message }
      }, status: 400
    end

    rescue_from ApiKeyValidator::InvalidKey do |e|
      render json: {
        message: 'Unauthorized',
        error: { details: e.message }
      }, status: 401
    end

    rescue_from UnsplashService::ImageNotFound do
      render json: {
        data: {
          message: 'No Image Found'
        }
      }, status: 200
    end
  end
end
