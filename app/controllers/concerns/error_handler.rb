module ErrorHandler extend ActiveSupport::Concern
  included do
    rescue_from Exception, with: :custom_response
  end

  def custom_response(exception)
    if exception.class == InvalidTransaction
      render json: {message: exception.message}
    elsif exception.class == InvalidToken
      render json: {message: "Invalid Token"},status: 400
    elsif exception.class == ValidationError
      render json: {message: exception.message},status: 400
    elsif exception.class == UnknownError
      render json: {message: "Something went wrong"},status: 500
    else
      render json: {message: exception}
    end
  end
end
