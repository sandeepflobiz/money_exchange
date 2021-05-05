class Renameaddcolumn < ActiveRecord::Migration[6.0]
  def change
    add_column :transfers, :secondary_currency, :integer, default: 0
    rename_column :transfers, :currency, :primary_currency
  end
end
