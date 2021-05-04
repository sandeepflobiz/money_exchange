class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.integer :account_number
      t.integer :user_id
      t.integer :rupee
      t.decimal :dollar
      t.decimal :pound
      t.decimal :yen
      t.decimal :taka
      t.timestamps
    end
  end
end
