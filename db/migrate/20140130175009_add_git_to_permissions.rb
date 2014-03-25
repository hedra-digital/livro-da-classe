class AddGitToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :git, :boolean, :default => false
  end
end
