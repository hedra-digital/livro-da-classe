class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :book_id
      t.integer :text_id
      t.integer :school_id

      t.timestamps
    end
    add_index :assignments, :book_id
    add_index :assignments, :text_id
    add_index :assignments, :school_id
  end
end
