# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120801183934) do

  create_table "assignments", :force => true do |t|
    t.integer  "book_id"
    t.integer  "text_id"
    t.integer  "school_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assignments", ["book_id"], :name => "index_assignments_on_book_id"
  add_index "assignments", ["school_id"], :name => "index_assignments_on_school_id"
  add_index "assignments", ["text_id"], :name => "index_assignments_on_text_id"

  create_table "books", :force => true do |t|
    t.integer  "school_id"
    t.string   "title",        :limit => 40
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.datetime "published_at"
  end

  add_index "books", ["school_id"], :name => "index_books_on_school_id"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "texts", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
