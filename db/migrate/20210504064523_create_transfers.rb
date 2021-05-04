class CreateTransfers < ActiveRecord::Migration[6.0]
  def change
    create_table :transfers do |t|
      t.integer :user_id
      t.integer :beneficiary_id
      t.integer :currency, default: 0
      t.timestamps
    end
  end
end
