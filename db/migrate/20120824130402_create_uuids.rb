class CreateUuids < ActiveRecord::Migration
	def change
		create_table "uuids", :force => true do |t|
			t.string  "uuid"
			t.integer "uuidable_id"
			t.string  "uuidable_type", :limit => 40
		end

		add_index "uuids", ["uuidable_id", "uuidable_type"], :name => "index_uuids_on_uuidable_id_and_uuidable_type"
	end
end