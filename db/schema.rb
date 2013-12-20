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

ActiveRecord::Schema.define(:version => 20131220005157) do

  create_table "comments", :force => true do |t|
    t.string   "body",       :null => false
    t.integer  "link_id",    :null => false
    t.integer  "parent_id"
    t.integer  "author_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["author_id"], :name => "index_comments_on_author_id"
  add_index "comments", ["link_id"], :name => "index_comments_on_link_id"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"

  create_table "links", :force => true do |t|
    t.string   "title",      :null => false
    t.string   "url",        :null => false
    t.string   "body"
    t.integer  "poster_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sub_links", :force => true do |t|
    t.integer  "sub_id",     :null => false
    t.integer  "link_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sub_links", ["sub_id"], :name => "index_sub_links_on_sub_id"

  create_table "subs", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "moderator_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "subs", ["name"], :name => "index_subs_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "password_digest", :null => false
    t.string   "session_token",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
