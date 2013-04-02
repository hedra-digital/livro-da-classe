class AddTemplateToBooks < ActiveRecord::Migration
  def change
    add_column :books, :template_id, :integer, :default => 1, :null => false
  end
end
