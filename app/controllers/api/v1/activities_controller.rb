class Api::V1::ActivitiesController < ApplicationController
  before_action { present?(:destination) }

  def show
    render json: ActivityFacade.activities(params[:destination])
  end
end
