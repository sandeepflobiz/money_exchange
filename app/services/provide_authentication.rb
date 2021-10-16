class ProvideAuthentication
  attr_accessor :request
  def initialize(request)
    @request = request
  end

  def authenticate_request
    begin
      unless user_id_in_token?
        raise ValidationError.new("Not Authenticated")
      end
      @current_user = User.find(auth_token[:user_id])

      # use initializer for calling redis (redo)
      redis = Redis.current
      saved_auth_token = redis.get(auth_token[:user_id].to_s)
      if saved_auth_token==@http_token
        return { message: "SUCCESS",data: @current_user}
      else
        raise InvalidToken.new("Invalid Token")
      end
    rescue JWT::VerificationError, JWT::DecodeError
      raise ValidationError.new("Not Authenticated")
    rescue InvalidToken=> error
      raise InvalidToken.new(error.message)
    rescue =>error
      raise UnknownError.new(error.message)
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
