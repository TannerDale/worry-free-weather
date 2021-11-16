class Api::V1::RoadTripsController < ApplicationController
  include ApiKeyValidator

  before_action { all_present?(%i[destination origin]) }
  before_action :validate_api_key

  def create
    trip = RoadTripFacade.road_trip(params[:destination], params[:origin])

    render json: RoadTripSerializer.serialize(trip)
  end
end
