class Addcolumn < ActiveRecord::Migration[6.0]
  def change
    add_column :exchanges, :amount, :decimal
    add_column :transfers, :amount, :decimal
  end
end
