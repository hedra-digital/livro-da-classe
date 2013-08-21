class AddPublishFormatToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :publish_format, :string
  end
end
