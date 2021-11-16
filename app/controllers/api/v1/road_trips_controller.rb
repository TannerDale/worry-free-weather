class Api::V1::RoadTripsController < ApplicationController
  def create
    trip = RoadTripFacade.road_trip(params[:destination], params[:origin])

    render json: RoadTripSerializer.serialize(trip)
  end
end
