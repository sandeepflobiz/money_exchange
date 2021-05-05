class Addaccnobeneficiary < ActiveRecord::Migration[6.0]
  def change
    add_column :transfers, :beneficiary_account_number, :integer
  end
end
