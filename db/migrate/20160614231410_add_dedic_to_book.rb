class AddDedicToBook < ActiveRecord::Migration
  def change
    add_column :books, :dedic, :string
    add_column :books, :acknowledgment, :string
    add_column :books, :resume_original_text, :string
    add_column :books, :acronym, :string    
  end
end
