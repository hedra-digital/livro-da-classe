class AddAttachmentSchoolLogoToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :school_logo
    end
  end

  def self.down
    drop_attached_file :projects, :school_logo
  end
end
