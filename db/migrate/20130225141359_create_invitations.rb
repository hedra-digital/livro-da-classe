class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :invited_id
      t.integer :book_id

      t.timestamps
    end
  end
end
