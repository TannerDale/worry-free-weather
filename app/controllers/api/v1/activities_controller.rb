class Api::V1::ActivitiesController < ApplicationController
  def show
    render json: ActivityFacade.activities(params[:destination])
  end
end
