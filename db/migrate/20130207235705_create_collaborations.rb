class CreateCollaborations < ActiveRecord::Migration
  def change
    create_table :collaborations, :id => false do |t|
      t.integer :collaborator_id
      t.integer :book_id

      t.timestamps
    end
  end
end
