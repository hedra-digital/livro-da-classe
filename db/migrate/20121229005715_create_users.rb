class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :educator
      t.integer :student_count
      t.string :school_name

      t.timestamps
    end
  end
end
