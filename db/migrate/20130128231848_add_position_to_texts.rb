class AddPositionToTexts < ActiveRecord::Migration
  def change
    add_column :texts, :position, :integer
  end
end
