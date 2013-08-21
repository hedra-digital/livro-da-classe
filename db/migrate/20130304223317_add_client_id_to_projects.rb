class AddClientIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :client_id, :integer
    add_index :projects, :client_id
  end
end
