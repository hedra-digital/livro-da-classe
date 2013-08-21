class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.datetime :published_at
      t.string :title
      t.string :uuid
      t.string :subtitle
      t.text :organizers
      t.text :directors
      t.text :coordinators

      t.timestamps
    end
  end
end
