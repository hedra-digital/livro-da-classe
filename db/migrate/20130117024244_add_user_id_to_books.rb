class AddUserIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :organizer_id, :integer
  end
end
