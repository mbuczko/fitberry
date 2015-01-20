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

ActiveRecord::Schema.define(:version => 20130718224235) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "challange_id"
    t.integer  "active_score"
    t.integer  "calories_out"
    t.integer  "steps"
    t.float    "distance"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "blogs", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.string   "author"
    t.datetime "published_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "htmlized"
    t.integer  "challange_id"
  end

  create_table "challanges", :force => true do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "distance_steps"
    t.float    "distance_km"
    t.boolean  "active"
    t.date     "activation_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "name"
    t.boolean  "finished"
    t.datetime "deadline"
    t.string   "origin"
    t.float    "converter"
    t.text     "htmlized"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "blog_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "htmlized"
  end

  create_table "milestones", :force => true do |t|
    t.integer  "challange_id"
    t.integer  "number"
    t.string   "name"
    t.float    "distance"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gmaps"
  end

  create_table "summaries", :force => true do |t|
    t.integer  "user_id"
    t.integer  "active_score"
    t.integer  "calories_out"
    t.integer  "steps"
    t.float    "distance"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.float    "distance"
    t.integer  "challange_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "password"
    t.string   "encrypted_password"
    t.string   "avatar"
    t.string   "town"
    t.string   "gender"
    t.string   "nickname"
    t.string   "about"
    t.string   "department"
    t.string   "role"
    t.date     "birth"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "is_lead"
    t.boolean  "is_admin"
    t.float    "base_distance",      :default => 0.0
    t.integer  "base_steps",         :default => 0
    t.integer  "base_calories",      :default => 0
    t.integer  "sign_in_count",      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "last_sync_date"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["uid", "provider"], :name => "index_users_on_uid_and_provider", :unique => true

end
