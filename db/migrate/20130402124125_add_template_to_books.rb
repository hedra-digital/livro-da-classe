class AddTemplateToBooks < ActiveRecord::Migration
  def change
    add_column :books, :template, :string
  end
end
