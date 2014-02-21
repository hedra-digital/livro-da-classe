class AddPagesCountToBooks < ActiveRecord::Migration
  def change
    add_column :books, :pages_count, :integer, :default => -1
  end
end
