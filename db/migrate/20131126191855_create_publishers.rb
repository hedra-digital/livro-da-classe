class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :url
      t.attachment :logo
      t.string :official_name
      t.string :address
      t.string :district
      t.string :city
      t.string :uf
      t.string :telephone
      
      t.timestamps
    end
  end
end
