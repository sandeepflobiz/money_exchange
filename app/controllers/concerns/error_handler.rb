module ErrorHandler extend ActiveSupport::Concern
  included do
    rescue_from Exception, with: :custom_response
  end

  def custom_response(exception)
    if exception.class == InvalidTransaction
      render json: {message: exception.message}
    elsif exception.class == InvalidToken
      render json: {message: "Invalid Token"}
    elsif exception.class == UnknownError
      render json: {message: "Something went wrong"}
    else
      render json: {message: "Unknow Error"}
    end
  end
end
