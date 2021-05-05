class Addaccountnuber < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :account_number, :integer
    add_column :transfers, :account_number, :integer
  end
end
