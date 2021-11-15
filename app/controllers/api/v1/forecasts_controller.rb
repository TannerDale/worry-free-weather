class Api::V1::ForecastsController < ApplicationController
  before_action { present?(:location) }

  def show
    render json: ForecastFacade.weather_data(params[:location])
  end
end
