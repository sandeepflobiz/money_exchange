class AuthenticationController < ApplicationController
  before_action :authenticate_request,only: %i[logout]
  def authenticate_user
    user = User.find_by(mobile: params[:mobile])&.authenticate(params[:password])
    if user
      render json: payload(user)
    else
      render json: {errors: ['Invalid Mobile/Password']}, status: :unauthorized
    end
  end

  def logout
    begin
      redis = Redis.current
      redis.del(@current_user.id)
      render json: {message: "You have successfully logged out"}
    rescue =>error
      render json: {message: error}
    end
  end
  private

  def payload(user)
    auth_token = JsonWebToken.encode({user_id: user.id})
    redis = Redis.current
    redis.set(user.id.to_s,auth_token)
    return nil unless user and user.id
    {
      auth_token: auth_token,
      user: {id: user.id, mobile: user.mobile}
    }
  end

end
