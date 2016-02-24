class AddPrintToPermissions < ActiveRecord::Migration
  def change
    add_column :permissions, :print, :boolean
  end
end
