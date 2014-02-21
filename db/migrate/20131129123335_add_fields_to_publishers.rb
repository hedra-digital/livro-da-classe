class AddFieldsToPublishers < ActiveRecord::Migration
  def change
  	add_column :publishers, :trello_email, :string
  	add_column :publishers, :text_email, :text
  	add_attachment :publishers, :logo_alternative
  end
end
