class RemoveStudentCountFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :student_count
  end

  def down
    add_column :users, :student_count, :integer
  end
end
