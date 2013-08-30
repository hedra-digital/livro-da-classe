class RemovePagesFromProject < ActiveRecord::Migration
  def up
    remove_column :projects, :pages
  end

  def down
  end
end
