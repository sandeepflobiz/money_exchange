class MoneyTransfer < ApplicationService
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

        enum_val = Transfer.currencies
        currency = enum_val.select{|key,hash| hash == @params[:currency]}.keys

        available_amount = account_details.read_attribute(currency[0])
        transfer_amount = @params[:amount]

        ActiveRecord::Base.transaction do
          if(available_amount>=transfer_amount)

            puts "amount transferred #{transfer_amount}"
            puts "remaining balance #{available_amount-transfer_amount}"

            account_details.update_attribute(currency[0],available_amount-transfer_amount)
            beneficiary_account.update_attribute(currency[0],beneficiary_account.read_attribute(currency[0])+transfer_amount)

            new_transfer.save!
            return {message: "tranfer successful"}
          else
            return {message: "invalid transaction"}
          end
        end
      else
        puts "invalid account number"
        return {message: "invalid account number"}
      end
  end

  private
    def tranfer_params
      @params.require(:transfer).permit(:beneficiary_id,:currency,:amount)
    end
end
