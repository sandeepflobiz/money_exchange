class MoneyTransfer < ApplicationService
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
      new_transfer = Transfer.new(tranfer_params)
      new_transfer.user_id = @params["user_id"]
      new_transfer.save!
  end

  private
    def tranfer_params
      @params.require(:transfer).permit(:beneficiary_id,:currency,:amount)
    end
end
