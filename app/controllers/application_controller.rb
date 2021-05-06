class ApplicationController < ActionController::API
  include ErrorHandler

  def authenticate
    # puts request.headers["Authorization"]
    authentication_obj = ProvideAuthentication.new(request).authenticate_request
    if authentication_obj[:message]=="SUCCESS"
      puts authentication_obj[:data]
      @current_user = authentication_obj[:data]
    else
      render json: {message: ["INVALID TOKEN"]}
    end
  end
end
