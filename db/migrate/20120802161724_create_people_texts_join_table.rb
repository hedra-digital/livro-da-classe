class CreatePeopleTextsJoinTable < ActiveRecord::Migration
  def change
  	create_table :people_texts, :id => false do |t|
  		t.integer :person_id
  		t.integer :text_id
  	end
  end
end
