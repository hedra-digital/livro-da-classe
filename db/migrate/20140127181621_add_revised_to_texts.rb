class AddRevisedToTexts < ActiveRecord::Migration
  def change
    add_column :texts, :revised, :boolean, :default => false
  end
end
