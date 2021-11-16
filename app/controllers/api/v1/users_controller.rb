class Api::V1::UsersController < ApplicationController
  def create
    user = User.create!(user_params)

    render json: UserSerializer.new(user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
