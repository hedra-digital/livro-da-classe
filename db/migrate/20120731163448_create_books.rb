class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
		t.integer :school_id
		t.string :title, :limit => "40"

		t.timestamps
    end
    add_index :books, :school_id 
  end
end
