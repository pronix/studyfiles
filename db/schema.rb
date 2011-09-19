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

ActiveRecord::Schema.define(:version => 20110918114841) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "documents", :force => true do |t|
    t.integer  "raiting"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_file_name"
    t.string   "item_content_type"
    t.integer  "item_file_size"
    t.datetime "item_updated_at"
    t.integer  "user_id"
    t.string   "name"
    t.boolean  "description"
    t.string   "sha"
  end

  create_table "folders", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "path_name"
  end

  create_table "messages", :force => true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.integer  "from_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_documents", :id => false, :force => true do |t|
    t.integer "document_id"
    t.integer "subject_id"
  end

  create_table "subject_folders", :id => false, :force => true do |t|
    t.integer "folder_id"
    t.integer "subject_id"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "university_subjects", :id => false, :force => true do |t|
    t.integer "university_id"
    t.integer "subject_id"
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.boolean  "subscriber"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  cmd = "psql --username=#{ActiveRecord::Base.connection.instance_variable_get(:@config)[:username]} -w -f `pg_config --sharedir`/contrib/ltree.sql #{ActiveRecord::Base.connection.instance_variable_get(:@config)[:database]}"
  puts cmd
  result = system(cmd)
  raise "Bad exit" unless result
  execute "ALTER TABLE \"documents\" ADD \"path\" LTREE NOT NULL DEFAULT 'Top'"
  execute "ALTER TABLE \"folders\" ADD \"path\" LTREE NOT NULL DEFAULT 'Top'"
end
