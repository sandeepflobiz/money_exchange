class AccountsController < ApplicationController
  before_action :authenticate_request
  def create
    begin
      new_account = Account.new(account_params)
      new_account.user_id = @current_user.id
      new_account.save!
      render json: {:message=>"Account created"}
    rescue =>error
      render json: {:message=>error.to_s}
    end
  end

  private
    def account_params
      params.require(:account).permit(:account_number,:rupee,:dollar,:pound,:yen,:taka)
    end
end
