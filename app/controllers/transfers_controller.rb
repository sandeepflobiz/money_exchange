class TransfersController < ApplicationController
  def create
    params["user_id"]=@current_user.id
    money_transfer = MoneyTransfer.new(params)
    message = money_transfer.call()
    MessageWorker.perform_in(1.minutes.from_now)
    render :json=>{message: message[:message]}
  end
end
