class AddImageToText < ActiveRecord::Migration
  def change
  	add_attachment :texts, :image
  end
end
