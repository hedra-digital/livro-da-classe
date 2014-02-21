class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.references :profile
      t.references :book_status
      t.boolean :read
      t.boolean :write
      t.boolean :execute

      t.timestamps
    end
  end
end
