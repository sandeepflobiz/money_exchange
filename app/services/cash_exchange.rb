class CashExchange < ApplicationService
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
      new_transfer = Exchange.new(exchange_params)
      new_transfer.user_id = @params["user_id"]
      new_transfer.save!
  end

  private
    def exchange_params
      @params.require(:exchange).permit(:primary_currency,:secondary_currency,:amount)
    end
end
