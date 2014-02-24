class AddDocumentToBook < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :document
    end
  end

  def self.down
    drop_attached_file :books, :document
  end
end
