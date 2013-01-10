class AddSchoolIdToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :school
    end
    add_index :users, :school_id
  end
end
