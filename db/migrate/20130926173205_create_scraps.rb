class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.integer :book_id
      t.text :content

      t.timestamps
    end
  end
end
