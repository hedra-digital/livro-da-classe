class AddUuidToBooksTable < ActiveRecord::Migration
  def change
  	add_column :books, :uuid, :string
  end
end
