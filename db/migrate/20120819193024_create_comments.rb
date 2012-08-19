class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :text_id
      t.string :author
      t.text :content

      t.timestamps
    end
  end
end
