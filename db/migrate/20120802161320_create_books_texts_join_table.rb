class CreateBooksTextsJoinTable < ActiveRecord::Migration
  def change
  	create_table :books_texts, :id => false do |t|
  		t.integer :book_id
  		t.integer :text_id
  	end
  end
end
