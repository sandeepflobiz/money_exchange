class AuthenticationController < ApplicationController
  def authenticate_user
    user = User.find_by(mobile: params[:mobile])&.authenticate(params[:password])
    if user
      render json: payload(user)
    else
      render json: {errors: ['Invalid Mobile/Password']}, status: :unauthorized
    end
  end

  private

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, mobile: user.mobile}
    }
  end

end
