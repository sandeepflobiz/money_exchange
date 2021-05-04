class TransfersController < ApplicationController
  before_action :authenticate_request
  def create
    params["user_id"]=@current_user.id
    begin
      MoneyTransfer.call(params)
      render :json=>{message:"Money was successfully exchanged"}
    rescue =>error
      render :json=>{message:error}
    end
  end
end
