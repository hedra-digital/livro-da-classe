class AddAttachmentCoverToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :books, :cover
  end
end
