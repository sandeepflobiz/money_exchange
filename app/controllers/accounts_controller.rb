class AccountsController < ApplicationController
  before_action :authenticate_request
  def create
    params["user_id"]=@current_user.id
    begin
      puts "hi #{params}"
      CreateAccount.call(params)
      render :json=>{message:"Account created successfully"}
    rescue =>error
      render :json=>{message:error}
    end
  end
end
