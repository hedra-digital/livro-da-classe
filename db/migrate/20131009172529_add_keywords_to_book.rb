class AddKeywordsToBook < ActiveRecord::Migration
  def up
    change_table :books do |t|
      t.string :keywords
    end
  end
  def down
    change_table :books do |t|
      t.remove :keywords
    end
  end
end