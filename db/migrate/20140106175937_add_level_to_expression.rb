class AddLevelToExpression < ActiveRecord::Migration
  def change
  	add_column :expressions, :level, :integer, :default => 1
  end
end
