class RemoveSchoolNameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :school_name
  end

  def down
    add_column :users, :school_name, :string
  end
end
