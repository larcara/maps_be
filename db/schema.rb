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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140327215934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "card_template_fields", force: true do |t|
    t.string  "section_name"
    t.string  "section_label"
    t.string  "template_field_id"
    t.string  "label"
    t.boolean "enabled"
    t.boolean "hidden"
    t.integer "position"
    t.integer "mobile"
    t.integer "open_data"
    t.boolean "mandatory"
    t.string  "options"
    t.string  "option_key"
    t.string  "field_type"
  end

  create_table "cards", force: true do |t|
    t.integer  "museum_id"
    t.string   "colore"
    t.string   "descrizione"
    t.string   "oggetto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "museum_fields", force: true do |t|
    t.integer  "museum_id"
    t.string   "form_name"
    t.string   "section_name"
    t.string   "section_label"
    t.integer  "card_template_field_id"
    t.string   "template_field_id"
    t.string   "label"
    t.boolean  "enabled"
    t.boolean  "hidden"
    t.integer  "position"
    t.integer  "mobile"
    t.integer  "open_data"
    t.boolean  "mandatory"
    t.string   "options"
    t.string   "option_key"
    t.string   "field_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "museums", force: true do |t|
    t.string   "museo_id"
    t.string   "name"
    t.string   "city"
    t.string   "address"
    t.string   "telephone"
    t.string   "logo"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "template_fields", force: true do |t|
    t.string   "field_name"
    t.string   "field_label"
    t.string   "field_description"
    t.string   "field_data_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "template_fields", ["field_name"], name: "index_template_fields_on_field_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "role"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.integer  "museum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
