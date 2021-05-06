class TransfersController < ApplicationController
  before_action :authenticate
  def create
    params["user_id"]=@current_user.id
    begin
      money_transfer = MoneyTransfer.new(params)
      message = money_transfer.call()
      render :json=>{message: message[:message]}
    rescue =>error
      render :json=>{message:error}
    end
  end
end
