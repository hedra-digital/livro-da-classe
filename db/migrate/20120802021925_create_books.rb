class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.datetime :published_at
      t.integer :school_id
      
      t.timestamps
    end
  end
end
