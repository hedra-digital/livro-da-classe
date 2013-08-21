class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.integer :book_id
      t.text :content
      t.string :title
      t.string :uuid

      t.timestamps
    end
  end
end
