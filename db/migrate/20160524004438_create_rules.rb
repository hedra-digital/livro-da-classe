# CreateRules Migration
class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :label
      t.string :command
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
