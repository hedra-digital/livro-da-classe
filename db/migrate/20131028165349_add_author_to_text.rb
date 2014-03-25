class AddAuthorToText < ActiveRecord::Migration
  def change
  	add_column :texts, :author, :string
  end
end
