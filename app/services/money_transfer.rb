class MoneyTransfer
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
      puts "tranfer process initiated"
      account_details = Account.find_by(user_id: @params["user_id"],account_number: @params[:account_number])
      beneficiary_account = Account.find_by(user_id: @params[:beneficiary_id],account_number: @params[:beneficiary_account_number])

      if account_details && beneficiary_account
        new_transfer = Transfer.new(tranfer_params)
        new_transfer.user_id = @params["user_id"]
        puts "preprocessing done"
        enum_val = Transfer.primary_currencies

        primary_currency_key = enum_val.select{|key,hash| hash == @params[:primary_currency]}.keys[0]
        secondary_currency_key = enum_val.select{|key,hash| hash == @params[:secondary_currency]}.keys[0]
        puts "preprocessing done #{primary_currency_key}"

        available_amount = account_details.read_attribute(primary_currency_key)
        transfer_amount = @params[:amount]
        puts "preprocessing done"

        ActiveRecord::Base.transaction do
          # for rupee to dollar
          transfer_amount = transfer_amount*72.5
          if(available_amount>=transfer_amount)

            puts "amount transferred #{transfer_amount}"
            puts "remaining balance #{available_amount-transfer_amount}"

            account_details.update_attribute(primary_currency_key,available_amount-transfer_amount)
            beneficiary_account.update_attribute(secondary_currency_key,beneficiary_account.read_attribute(secondary_currency_key)+transfer_amount)

            new_transfer.save!
            return {message: "tranfer successful"}
          else
            raise InvalidTransaction.new
          end
        end
      else
        puts "invalid account number"
        # return {message: "invalid account number"}
        raise InvalidAccount.new
      end
  end

  private
    def tranfer_params
      @params.require(:transfer).permit(:beneficiary_id,:primary_currency,:secondary_currency,:amount)
    end
end
