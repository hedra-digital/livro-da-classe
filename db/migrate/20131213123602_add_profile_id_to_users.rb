class AddProfileIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :profile_id, :integer
    add_index :users, :profile_id
  end
end
