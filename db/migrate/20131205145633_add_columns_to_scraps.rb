class AddColumnsToScraps < ActiveRecord::Migration
  def change
  	add_column :scraps, :is_admin, :boolean
  	add_column :scraps, :admin_name, :string
  	add_column :scraps, :parent_scrap_id, :integer
  	add_column :scraps, :answered, :boolean
  end
end
