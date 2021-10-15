class MoneyTransfer
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
      redis = $redis
      account_details = Account.valid_account(@params["user_id"],@params[:account_number])[0]
      beneficiary_account = Account.valid_account(@params[:beneficiary_id],@params[:beneficiary_account_number])[0]

      if account_details && beneficiary_account
        new_transfer = Transfer.new(tranfer_params)
        new_transfer.user_id = @params["user_id"]

        primary_value = redis.get((@params[:primary_currency]).to_s).to_d
        secondary_value = redis.get((@params[:secondary_currency]).to_s).to_d
        conversion_rate =  primary_value/secondary_value
        available_amount = account_details[@params[:primary_currency]]
        transfer_amount = @params[:amount]

        ActiveRecord::Base.transaction do
          # for rupee to dollar
          amount_transferred = transfer_amount*conversion_rate
          if(available_amount>=amount_transferred)
            account_details.update_attribute(@params[:primary_currency],available_amount-amount_transferred)
            beneficiary_account.update_attribute(@params[:secondary_currency],beneficiary_account[@params[:secondary_currency]]+transfer_amount)

            new_transfer.account_number = @params[:account_number]
            new_transfer.beneficiary_account_number = @params[:beneficiary_account_number]
            new_transfer.save!
            return {message: "tranfer successful"}
          else
            raise InvalidTransaction.new("Invalid Transaction")
          end
        end
      else
        raise InvalidTransaction.new("Invalid Account Number")
      end
  end

  private
    def tranfer_params
      @params.require(:transfer).permit(:beneficiary_id,:primary_currency,:secondary_currency,:amount)
    end
end
