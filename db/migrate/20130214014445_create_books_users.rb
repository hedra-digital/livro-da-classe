class CreateBooksUsers < ActiveRecord::Migration
  def change
    create_table :books_users, :id => false do |t|
      t.references :book, :user
    end
    add_index :books_users, [:book_id, :user_id]
  end
end
