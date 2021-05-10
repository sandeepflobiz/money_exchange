class CashExchange
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
      redis = $redis

      # account_details = Account.find_by(user_id: @params["user_id"],account_number: @params[:account_number])
      account_details = Account.valid_account(@params["user_id"],@params[:account_number])[0]
      if account_details
        new_transfer = Exchange.new(exchange_params)
        # redis_key = @params[:primary_currency]+"_"+@params[:secondary_currency]
        primary_value = redis.get((@params[:primary_currency]).to_s).to_d
        secondary_value = redis.get((@params[:secondary_currency]).to_s).to_d
        conversion_rate =  primary_value/secondary_value
        available_amount = account_details[@params[:primary_currency]]
        transfer_amount = @params[:amount]
        puts "here"
        ActiveRecord::Base.transaction do
          #static for rupee to dollar exchange
          # ans = 10/0
          if (available_amount/(transfer_amount*conversion_rate)>=1)
            puts "valid"
            amount_transferred = (transfer_amount*conversion_rate)
            # Exchange.save!
            puts "amount transferred #{amount_transferred}"
            puts "remaining balance #{available_amount-amount_transferred}"

            account_details.update_attribute(@params[:primary_currency],available_amount-amount_transferred)
            account_details.update_attribute(@params[:secondary_currency],account_details[@params[:secondary_currency]]+transfer_amount)

            new_transfer.user_id = @params["user_id"]
            new_transfer.account_number = @params[:account_number]
            new_transfer.save!
            return {message: "money exchanged successfully"}

          else
            puts "invalid"
            raise InvalidTransaction.new("Invalid Transaction")
          end
        end
      else
        puts "invalid account number"
        raise InvalidTransaction.new("Invalid Transaction")
      end
  end

  private
    def exchange_params
      @params.require(:exchange).permit(:primary_currency,:secondary_currency,:amount)
    end
end
