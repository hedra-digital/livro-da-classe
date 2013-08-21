class RemoveEducatorFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :educator
  end

  def down
    add_column :users, :educator, :boolean
  end
end
