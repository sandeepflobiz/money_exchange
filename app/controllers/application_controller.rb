class ApplicationController < ActionController::API
  include ErrorHandler
  attr_reader :current_user

  protected
  def authenticate_request
    begin
      unless user_id_in_token?
        render json: { errors: ['Not Authenticated'] }, status: :unauthorized
        return
      end
      @current_user = User.find(auth_token[:user_id])
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    rescue =>error
      render json: { errors: ['Invalid Token'] }, status: :unauthorized
    end
  end

  private
  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    puts auth_token # contains {"user_id"=>1}
    puts http_token # contains eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.wJWmpJgyWYJv2BBySh8M5te83UBwDUMkHsWi_F4zJAo
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
