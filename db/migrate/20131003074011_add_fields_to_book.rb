class AddFieldsToBook < ActiveRecord::Migration
  def up
    change_table :books do |t|
      t.string :institution
      t.string :street
      t.string :number
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :klass
      t.string :librarian_name
      t.string :cdu
      t.string :cdd
    end
  end
  def down
    change_table :books do |t|
      t.remove :institution
      t.remove :street
      t.remove :number
      t.remove :city
      t.remove :state
      t.remove :zipcode
      t.remove :klass
      t.remove :librarian_name
      t.remove :cdu
      t.remove :cdd
    end
  end
end