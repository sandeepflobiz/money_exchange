class ExchangesController < ApplicationController
  before_action :authenticate_request
  def create
    redis = Redis.current
    redis.set("saimon","sasa")
    # ExchangeRateWorker.perform_in(1.minute)
    params["user_id"]=@current_user.id

    message = CashExchange.new(params).call()
    render :json=>{message: message[:message]}
  end
end
