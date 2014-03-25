class AddFieldsToBookDatas < ActiveRecord::Migration
  def change
  	add_column :book_datas, :grafica, :string
  	add_column :book_datas, :papelmiolo, :string
  	add_column :book_datas, :numeroedicao, :integer, :default => 1
  end
end
