class AddAbstractToBooks < ActiveRecord::Migration
  def change
  	add_column :books, :abstract, :text
  end
end
