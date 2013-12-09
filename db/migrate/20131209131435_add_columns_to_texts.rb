class AddColumnsToTexts < ActiveRecord::Migration
  def change
  	add_column :texts, :valid_content, :boolean
  end
end
