class AddDescriptionToExpressions < ActiveRecord::Migration
  def change
  	add_column :expressions, :description, :text
  end
end
