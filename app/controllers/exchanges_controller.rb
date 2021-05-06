class ExchangesController < ApplicationController
  before_action :authenticate, only: :create
  def create
    redis = Redis.current
    redis.set("saimon","sasa")
    # ExchangeRateWorker.perform_in(1.minute)
    params["user_id"]=@current_user.id

    message = CashExchange.new(params).call()
    render :json=>{message: message[:message]}
  end

  def updateExchangeRate
    begin
      exchange_rate = ExchangeRate.new(params).call
      render json: {message: "Redis updated"}
    rescue =>error
      render json: {message: error}
    end
  end
end
