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

ActiveRecord::Schema.define(:version => 20140212130714) do

  create_table "book_datas", :force => true do |t|
    t.integer  "book_id"
    t.string   "subtit"
    t.string   "autor"
    t.string   "sumariotitulo"
    t.string   "sumarioautor"
    t.string   "organizador"
    t.string   "introdutor"
    t.string   "tradutor"
    t.text     "orelha"
    t.text     "quartacapa",               :limit => 255
    t.string   "copyrightlivro"
    t.string   "copyrighttraducao"
    t.string   "copyrightorganizacao"
    t.string   "copyrightilustracao"
    t.string   "copyrightintroducao"
    t.string   "titulooriginal"
    t.string   "edicaoconsultada"
    t.string   "primeiraedicao"
    t.string   "agradecimentos"
    t.string   "indicacao"
    t.string   "isbn"
    t.string   "ano"
    t.string   "edicao"
    t.string   "coedicao"
    t.string   "assistencia"
    t.string   "revisao"
    t.string   "preparacao"
    t.string   "capa"
    t.string   "imagemcapa"
    t.string   "imagemficha_file_name"
    t.string   "imagemficha_content_type"
    t.integer  "imagemficha_file_size"
    t.datetime "imagemficha_updated_at"
    t.string   "instituicao"
    t.string   "logradouro"
    t.string   "numero"
    t.string   "cidadeinstituicao"
    t.string   "estado"
    t.string   "cep"
    t.string   "diretor"
    t.string   "coordenador"
    t.string   "turma"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "cidade"
    t.text     "release"
    t.text     "trechotexto"
    t.text     "sobreobra"
    t.text     "sobreautor"
    t.text     "sobreorganizador"
    t.text     "sobretradutor"
    t.text     "resumo"
    t.string   "dimensao"
    t.string   "peso"
    t.string   "gramaturamiolo"
    t.string   "cormiolo"
    t.string   "palavraschave"
    t.boolean  "publicaebook"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.string   "capainteira_file_name"
    t.string   "capainteira_content_type"
    t.integer  "capainteira_file_size"
    t.datetime "capainteira_updated_at"
  end

  create_table "book_statuses", :force => true do |t|
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "books", :force => true do |t|
    t.datetime "published_at"
    t.string   "title"
    t.string   "uuid"
    t.string   "subtitle"
    t.text     "organizers"
    t.text     "directors"
    t.text     "coordinators"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "organizer_id"
    t.string   "template"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "institution"
    t.string   "street"
    t.string   "number"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "klass"
    t.string   "librarian_name"
    t.string   "cdu"
    t.string   "cdd"
    t.string   "keywords"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "publisher_id"
    t.text     "abstract"
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

  create_table "cover_infos", :force => true do |t|
    t.integer  "book_id"
    t.string   "titulo_linha1"
    t.string   "titulo_linha2"
    t.string   "titulo_linha3"
    t.string   "autor"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "texto_quarta_capa"
    t.string   "capa_imagem_file_name"
    t.string   "capa_imagem_content_type"
    t.integer  "capa_imagem_file_size"
    t.datetime "capa_imagem_updated_at"
    t.string   "capa_detalhe_file_name"
    t.string   "capa_detalhe_content_type"
    t.integer  "capa_detalhe_file_size"
    t.datetime "capa_detalhe_updated_at"
    t.string   "cor_primaria"
    t.string   "cor_secundaria"
    t.integer  "logo_x1"
    t.integer  "logo_x2"
    t.integer  "logo_y1"
    t.integer  "logo_y2"
    t.integer  "capa_imagem_x1"
    t.integer  "capa_imagem_x2"
    t.integer  "capa_imagem_y1"
    t.integer  "capa_imagem_y2"
    t.integer  "capa_detalhe_x1"
    t.integer  "capa_detalhe_x2"
    t.integer  "capa_detalhe_y1"
    t.integer  "capa_detalhe_y2"
    t.integer  "logo_w"
    t.integer  "logo_h"
    t.integer  "capa_imagem_w"
    t.integer  "capa_imagem_h"
    t.integer  "capa_detalhe_w"
    t.integer  "capa_detalhe_h"
  end

  create_table "default_covers", :force => true do |t|
    t.string   "default_cover_file_name"
    t.string   "default_cover_content_type"
    t.integer  "default_cover_file_size"
    t.datetime "default_cover_updated_at"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "expressions", :force => true do |t|
    t.string   "target"
    t.string   "replace"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "level"
    t.text     "description"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "invited_id"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "permissions", :force => true do |t|
    t.integer  "profile_id"
    t.integer  "book_status_id"
    t.boolean  "read"
    t.boolean  "write"
    t.boolean  "execute"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.boolean  "review",         :default => false
    t.boolean  "git",            :default => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "book_id"
    t.date     "release_date"
    t.date     "finish_date"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "client_id"
    t.string   "school_logo_file_name"
    t.string   "school_logo_content_type"
    t.integer  "school_logo_file_size"
    t.datetime "school_logo_updated_at"
    t.string   "publish_format"
    t.integer  "quantity",                 :default => 100
    t.boolean  "engaged",                  :default => false
    t.integer  "status"
  end

  add_index "projects", ["book_id"], :name => "index_projects_on_book_id"
  add_index "projects", ["client_id"], :name => "index_projects_on_client_id"

  create_table "publishers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "official_name"
    t.string   "address"
    t.string   "district"
    t.string   "city"
    t.string   "uf"
    t.string   "telephone"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.string   "trello_email"
    t.text     "text_email"
    t.string   "logo_alternative_file_name"
    t.string   "logo_alternative_content_type"
    t.integer  "logo_alternative_file_size"
    t.datetime "logo_alternative_updated_at"
  end

  create_table "scraps", :force => true do |t|
    t.integer  "book_id"
    t.text     "content"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.boolean  "is_admin"
    t.string   "admin_name"
    t.integer  "parent_scrap_id"
    t.boolean  "answered"
  end

  create_table "texts", :force => true do |t|
    t.integer  "book_id"
    t.text     "content",            :limit => 2147483647
    t.string   "title"
    t.string   "uuid"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "position"
    t.integer  "user_id"
    t.boolean  "enabled",                                  :default => true
    t.string   "author"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "valid_content"
    t.boolean  "revised",                                  :default => false
    t.string   "subtitle"
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
    t.string   "telephone"
    t.integer  "profile_id"
  end

  add_index "users", ["profile_id"], :name => "index_users_on_profile_id"

end
