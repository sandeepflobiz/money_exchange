class ApplicationController < ActionController::API
  include ErrorHandler
  before_action :authenticate
  def authenticate
    authentication_obj = ProvideAuthentication.new(request).authenticate_request
    if authentication_obj[:message]=="SUCCESS"
      @current_user = authentication_obj[:data]
    else
      raise InvalidToken.new
    end
  end
end
