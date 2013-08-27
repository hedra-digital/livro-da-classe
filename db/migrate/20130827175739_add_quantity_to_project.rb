class AddQuantityToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :quantity, :integer
  end
end
