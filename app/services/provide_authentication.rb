class ProvideAuthentication
  attr_accessor :request
  def initialize(request)
    @request = request
  end

  def authenticate_request
    begin
      unless user_id_in_token?
        return { message: ['Not Authenticated'] }
        return
      end
      @current_user = User.find(auth_token[:user_id])

      # use initializer for calling redis (redo)
      redis = Redis.current
      saved_auth_token = redis.get(auth_token[:user_id].to_s)
      if saved_auth_token==@http_token
        return { message: "SUCCESS",data: @current_user}
      else
        return { message: ['Invalid Token'] }
      end
    rescue JWT::VerificationError, JWT::DecodeError
      return { message: ['Not Authenticated'] }
    rescue =>error
      return { message: error}
    end
  end

  private
  def http_token
      @http_token ||= if @request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
