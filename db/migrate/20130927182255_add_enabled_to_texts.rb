class AddEnabledToTexts < ActiveRecord::Migration
  def change
  	add_column :texts, :enabled, :boolean, :default => true
  end
end
