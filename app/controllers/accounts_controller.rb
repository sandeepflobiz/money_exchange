class AccountsController < ApplicationController
  # before_action :authenticate
  def create
    puts "in"
    params["user_id"]=@current_user.id
    begin
      puts "hi #{params}"
      create_account = CreateAccount.new(params)
      create_account.call()
      # CreateAccount.call(params)
      render :json=>{message:"Account created successfully"}
    rescue =>error
      render :json=>{message:error}
    end
  end

  def index
    params["user_id"] = @current_user.id
    begin
      message = MiniStatement.new(params).call()
      render json: {message: message[:message],data: message[:data]}
    rescue =>error
      render json: {message: error}
    end
  end
end
