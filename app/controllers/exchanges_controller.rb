class ExchangesController < ApplicationController
  before_action :authenticate_request
  def create
    params["user_id"]=@current_user.id

    message = CashExchange.new(params).call()
    render :json=>{message: message[:message]}
    # rescue =>error
    #   render :json=>{message:error}
    # end
  end
end
