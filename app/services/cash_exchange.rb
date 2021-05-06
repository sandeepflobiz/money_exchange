class CashExchange
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
      redis = Redis.current

      account_details = Account.lock("FOR UPDATE NOWAIT").find_by(user_id: @params["user_id"],account_number: @params[:account_number])

      if account_details
        new_transfer = Exchange.new(exchange_params)
        enum_val = Exchange.primary_currencies

        primary_currency_key = enum_val.select{|key, hash| hash == @params[:primary_currency]}.keys[0]
        secondary_currency_key = enum_val.select{|key,hash| hash == @params[:secondary_currency]}.keys[0]

        redis_key = primary_currency_key.to_s+"_"+secondary_currency_key
        conversion_rate =  redis.get(redis_key).to_d

        available_amount = account_details.read_attribute(primary_currency_key)

        ActiveRecord::Base.transaction do
          transfer_amount = @params[:amount]

          #static for rupee to dollar exchange
          # ans = 10/0
          if (available_amount/(transfer_amount*conversion_rate)>=1)
            puts "valid"
            amount_transferred = (transfer_amount*conversion_rate)
            # Exchange.save!
            puts "amount transferred #{amount_transferred}"
            puts "remaining balance #{available_amount-amount_transferred}"

            account_details.update_attribute(primary_currency_key,available_amount-amount_transferred)
            account_details.update_attribute(secondary_currency_key,account_details.read_attribute(secondary_currency_key)+transfer_amount)

            new_transfer.user_id = @params["user_id"]
            new_transfer.account_number = @params[:account_number]
            new_transfer.save!
            return {message: "money exchanged successfully"}

          else
            puts "invalid"
            raise InvalidTransaction
          end
        end
      else
        puts "invalid account number"
        raise InvalidAccount
        return {message: "invalid account number"}
      end
  end

  private
    def exchange_params
      @params.require(:exchange).permit(:primary_currency,:secondary_currency,:amount)
    end
end
