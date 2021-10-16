class MiniStatement
  attr_accessor :params
  def initialize(params)
    @params =params
  end

  def call

    user_id = @params["user_id"]
    @all_transactions=[]

    entire_transactions = User.joins(:exchanges,:transfers).order("created_at DESC").limit(15)[0]

    entire_transactions.exchanges.each do |trans|
      statements={amount: trans.amount,primary_currency: trans.primary_currency,secondary_currency: trans.secondary_currency,
                  beneficiary_id: nil,account_number: trans.account_number,
                  beneficiary_account_number: nil,date: trans.created_at}
      @all_transactions << statements
    end

    entire_transactions.transfers.each do |trans|
      statements={amount: trans.amount,primary_currency: trans.primary_currency,secondary_currency: trans.secondary_currency,
                  beneficiary_id: trans.beneficiary_id,account_number: trans.account_number,
                  beneficiary_account_number: trans.beneficiary_account_number,date: trans.created_at}
      @all_transactions << statements
    end

    return {message: "SUCCESS",data: @all_transactions}
  end
end
