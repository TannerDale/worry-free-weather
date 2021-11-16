class Api::V1::SessionsController < ApplicationController
  before_action :validate_user

  def create
    render json: UserSerializer.new(@user), status: 200
  end

  private

  def validate_user
    @user = User.find_by(email: params[:email])

    return if @user&.authenticate(params[:password])

    render json: { error: { details: 'Invalid email or password' } }, status: 400
  end
end
