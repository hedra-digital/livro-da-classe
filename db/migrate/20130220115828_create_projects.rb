class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :book
      t.date :release_date
      t.date :finish_date

      t.timestamps
    end
    add_index :projects, :book_id
  end
end
