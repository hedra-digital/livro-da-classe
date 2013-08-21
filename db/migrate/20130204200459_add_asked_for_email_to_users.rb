class AddAskedForEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :asked_for_email, :boolean
  end
end
