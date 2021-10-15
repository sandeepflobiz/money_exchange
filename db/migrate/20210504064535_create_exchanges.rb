class CreateExchanges < ActiveRecord::Migration[6.0]
  def change
    create_table :exchanges,id: :uuid do |t|
      t.integer :user_id
      t.integer :primary_currency,default: 0
      t.integer :secondary_currency,default: 0
      t.timestamps
    end
  end
end
