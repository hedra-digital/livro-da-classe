class AddFinishedAtToBooksAndTexts < ActiveRecord::Migration
  def change
 	add_column :books, :finished_at, :datetime
 	add_column :texts, :finished_at, :datetime
  end
end
