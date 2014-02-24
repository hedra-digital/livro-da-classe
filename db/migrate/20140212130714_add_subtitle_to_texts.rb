class AddSubtitleToTexts < ActiveRecord::Migration
  def change
    add_column :texts, :subtitle, :string
  end
end
