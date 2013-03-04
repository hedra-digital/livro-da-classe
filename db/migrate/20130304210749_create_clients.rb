class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.references :user
      t.string :position
      t.string :phone
      t.string :company

      t.timestamps
    end
    add_index :clients, :user_id
  end
end
