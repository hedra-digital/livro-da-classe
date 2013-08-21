class CreateDefaultCovers < ActiveRecord::Migration
  def change
    create_table :default_covers do |t|
      t.string :default_cover_file_name 
      t.string :default_cover_content_type
      t.integer :default_cover_file_size
      t.datetime :default_cover_updated_at
      t.timestamps
    end
  end
end