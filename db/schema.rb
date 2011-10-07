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

ActiveRecord::Schema.define(:version => 20111006040606) do

  create_table "campaigns", :force => true do |t|
    t.string   "name"
    t.integer  "dm_id"
    t.text     "description"
    t.boolean  "private",     :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "campaigns", ["dm_id"], :name => "index_campaigns_on_dm_id"

  create_table "people", :force => true do |t|
    t.string   "name"
    t.integer  "campaign_id"
    t.text     "description"
    t.text     "public_description"
    t.boolean  "private",            :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["campaign_id"], :name => "index_people_on_campaign_id"

  create_table "person_uploads", :force => true do |t|
    t.string   "upload",                        :null => false
    t.string   "caption"
    t.integer  "person_id",                     :null => false
    t.boolean  "private",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_uploads", ["person_id"], :name => "index_person_uploads_on_person_id"

  create_table "person_veil_passes", :force => true do |t|
    t.integer  "person_id",                          :null => false
    t.integer  "user_id",                            :null => false
    t.boolean  "includes_uploads", :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "person_veil_passes", ["person_id"], :name => "index_person_veil_passes_on_person_id"
  add_index "person_veil_passes", ["user_id"], :name => "index_person_veil_passes_on_user_id"

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
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
    t.string   "name",                                                  :null => false
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
