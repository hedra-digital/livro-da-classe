class AddEngagedToProjects < ActiveRecord::Migration
  def up
    add_column :projects, :engaged, :boolean, :default => false
  end

  def down
    remove_column :projects, :engaged
  end
end
