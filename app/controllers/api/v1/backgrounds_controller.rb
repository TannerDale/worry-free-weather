class Api::V1::BackgroundsController < ApplicationController
  include ImageErrorHandler

  before_action { present?(:location) }

  def show
    render json: ImageFacade.location_image(params[:location])
  end
end
