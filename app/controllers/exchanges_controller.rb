class ExchangesController < ApplicationController
  skip_before_action :authenticate,only: %i[updateExchangeRate]
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
