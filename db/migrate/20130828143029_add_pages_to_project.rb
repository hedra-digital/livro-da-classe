class AddPagesToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :pages, :integer
  end
end
