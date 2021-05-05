class CreateAccount
  attr_accessor :params,:error

  def initialize(params)
    puts "initializer has been called"
    @params = params
  end

  def call
      puts "call method has been called"
      new_account = Account.new(account_params)
      new_account.user_id = @params["user_id"]
      new_account.save!
  end

  private
    def account_params
      @params.require(:account).permit(:account_number,:rupee,:dollar,:pound,:yen,:taka)
    end
end
