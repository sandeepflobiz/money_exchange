module ErrorHandler extend ActiveSupport::Concern
  included do
    rescue_from Exception, with: :custom_response
  end

  def custom_response(exception)
    puts "exception is #{exception}"
    if exception.class == InvalidTransaction
      render json: {message: "Invalid Transaction"}
    elsif exception.class == InvalidAccount
      render json: {message: "Invalid Account Number"}
    else
      render json: {message: "Unknow Error"}
    end
    # render json: {message: "Something went wrong"}
  end
end
