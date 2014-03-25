class AddQuantityToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :quantity, :integer, :default => 100
  end
end
