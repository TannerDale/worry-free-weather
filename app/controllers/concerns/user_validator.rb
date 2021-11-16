module UserValidator
  def validate_user
    @user = User.find_by(email: params[:email])

    return if @user&.authenticate(params[:password])

    render json: { error: { details: 'Invalid email or password' } }, status: 400
  end
end
