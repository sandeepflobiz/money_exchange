class MiniStatement
  attr_accessor :params
  def initialize(params)
    @params =params
  end

  def call

    user_id = @params["user_id"]
    puts user_id
    @all_transactions=[]

    exchange_transactions = Exchange.where(user_id: user_id).order("created_at DESC").limit(5)
    debit_transfer_transactions = Transfer.where(user_id: user_id).order("created_at DESC").limit(5)
    credit_transfer_transactions = Transfer.where(beneficiary_id: user_id).order("created_at DESC").limit(5)

    exchange_transactions.each do |trans|
      statements={amount: trans.amount,primary_currency: trans.primary_currency,secondary_currency: trans.secondary_currency,
                  account_number: trans.account_number,date: trans.created_at}
      puts statements
      @all_transactions << statements
    end

    debit_transfer_transactions.each do |trans|
      statements={amount: trans.amount,primary_currency: trans.primary_currency,secondary_currency: trans.secondary_currency,
                  beneficiary_id: trans.beneficiary_id,account_number: trans.account_number,
                  beneficiary_account_number: trans.beneficiary_account_number,date: trans.created_at}
      @all_transactions << statements
    end

    credit_transfer_transactions.each do |trans|
      statements={amount: trans.amount,primary_currency: trans.primary_currency,secondary_currency: trans.secondary_currency,
                  user_id: trans.user_id,account_number: trans.beneficiary_account_number,
                  donor_account_number: trans.account_number,date: trans.created_at}
      @all_transactions << statements
    end


    return {message: "SUCCESS",data: @all_transactions}
  end
end
