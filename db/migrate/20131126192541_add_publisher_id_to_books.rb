class AddPublisherIdToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :publisher_id, :integer
  end
end