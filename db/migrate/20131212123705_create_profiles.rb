class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :desc

      t.timestamps
    end
  end
end
