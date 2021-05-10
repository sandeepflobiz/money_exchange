module ErrorHandler extend ActiveSupport::Concern
  included do
    rescue_from Exception, with: :custom_response
  end

  def custom_response(exception)
    puts "exception is #{exception}"
    if exception.class == InvalidTransaction
      puts exception
      render json: {message: exception.message}
    elsif exception.class == InvalidToken
      render json: {message: "Invalid Token"}
    elsif exception.class == UnknownError
      render json: {message: "Something went wrong"}
    else
      render json: {message: "Unknow Error"}
    end
    # render json: {message: "Something went wrong"}
  end
end
