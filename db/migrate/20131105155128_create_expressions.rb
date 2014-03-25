class CreateExpressions < ActiveRecord::Migration
  def change
    create_table :expressions do |t|
      t.string :target
      t.string :replace

      t.timestamps
    end
  end
end
