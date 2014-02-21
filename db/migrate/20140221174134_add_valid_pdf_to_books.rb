class AddValidPdfToBooks < ActiveRecord::Migration
  def change
    add_column :books, :valid_pdf, :boolean, :default => true
  end
end
