class ChangeContentFromTexts < ActiveRecord::Migration
  def up
  	change_column :texts, :content, :text, :limit => 4294967295
  end

  def down
  end
end
