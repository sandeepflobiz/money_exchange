class CashExchange
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
      account_details = Account.find_by(user_id: @params["user_id"],account_number: @params[:account_number])

      if account_details
        new_transfer = Exchange.new(exchange_params)
        enum_val = Exchange.primary_currencies

        primary_currency = enum_val.select{|key, hash| hash == @params[:primary_currency]}.keys
        secondary_currency = enum_val.select{|key,hash| hash == @params[:secondary_currency]}.keys

        available_amount = account_details.read_attribute(primary_currency[0])

        ActiveRecord::Base.transaction do
          transfer_amount = @params[:amount]

          #static for rupee to dollar exchange
          # ans = 10/0
          if (available_amount/(transfer_amount*72.5)>=1)
            puts "valid"
            amount_transferred = (transfer_amount*72.5)
            # Exchange.save!
            puts "amount transferred #{amount_transferred}"
            puts "remaining balance #{available_amount-amount_transferred}"

            account_details.update_attribute(primary_currency[0],available_amount-amount_transferred)
            account_details.update_attribute(secondary_currency[0],account_details.read_attribute(secondary_currency[0])+amount_transferred)

            new_transfer.user_id = @params["user_id"]
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
