class AddIndexToUsersMobile < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :mobile,unique: true
  end
end
