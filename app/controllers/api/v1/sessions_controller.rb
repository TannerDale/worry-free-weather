class Api::V1::SessionsController < ApplicationController
  include UserValidator

  before_action :validate_user

  def create
    render json: UserSerializer.new(@user), status: 200
  end
end
