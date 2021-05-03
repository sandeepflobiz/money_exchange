class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.string :password
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
