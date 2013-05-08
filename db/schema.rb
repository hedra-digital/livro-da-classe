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

ActiveRecord::Schema.define(:version => 20130507205603) do

  create_table "books", :force => true do |t|
    t.datetime "published_at"
    t.string   "title"
    t.string   "uuid"
    t.string   "subtitle"
    t.text     "organizers"
    t.text     "directors"
    t.text     "coordinators"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "organizer_id"
    t.string   "template"
  end

  create_table "books_users", :id => false, :force => true do |t|
    t.integer "book_id"
    t.integer "user_id"
  end

  add_index "books_users", ["book_id", "user_id"], :name => "index_books_users_on_book_id_and_user_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "clients", :force => true do |t|
    t.integer  "user_id"
    t.string   "position"
    t.string   "phone"
    t.string   "company"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clients", ["user_id"], :name => "index_clients_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "text_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "invited_id"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "book_id"
    t.date     "release_date"
    t.date     "finish_date"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "client_id"
    t.string   "school_logo_file_name"
    t.string   "school_logo_content_type"
    t.integer  "school_logo_file_size"
    t.datetime "school_logo_updated_at"
  end

  add_index "projects", ["book_id"], :name => "index_projects_on_book_id"
  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"

  create_table "texts", :force => true do |t|
    t.integer  "book_id"
    t.text     "content"
    t.string   "title"
    t.string   "uuid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "position"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "asked_for_email"
  end

end
