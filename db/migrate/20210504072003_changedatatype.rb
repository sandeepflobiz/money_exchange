class Changedatatype < ActiveRecord::Migration[6.0]
  def change
    change_table :accounts do |t|
      t.change :rupee, :decimal
    end
  end
end
