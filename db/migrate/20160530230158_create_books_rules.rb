class CreateBooksRules < ActiveRecord::Migration
  def change
    create_table :books_rules, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :rule, index: true
    end
  end
end
