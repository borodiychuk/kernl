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

ActiveRecord::Schema.define(version: 20160228141626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attachments", force: :cascade do |t|
    t.string   "file_uid"
    t.string   "file_name"
    t.integer  "ordering"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "value_id",   null: false
  end

  add_index "attachments", ["value_id"], name: "index_attachments_on_value_id", using: :btree

  create_table "entries", force: :cascade do |t|
    t.boolean  "enabled",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "storage_id",                 null: false
  end

  add_index "entries", ["storage_id"], name: "index_entries_on_storage_id", using: :btree

  create_table "fields", force: :cascade do |t|
    t.string   "identifier",                            null: false
    t.string   "name",                                  null: false
    t.string   "type",                                  null: false
    t.integer  "ordering"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "storage_id",                            null: false
    t.boolean  "shown_in_backend_list", default: false, null: false
  end

  add_index "fields", ["storage_id", "identifier"], name: "index_fields_on_storage_id_and_identifier", unique: true, using: :btree
  add_index "fields", ["storage_id"], name: "index_fields_on_storage_id", using: :btree

  create_table "storages", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id", null: false
  end

  add_index "storages", ["account_id"], name: "index_storages_on_account_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                default: "",      null: false
    t.string   "email",                                 null: false
    t.string   "encrypted_password",  default: "",      null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider",            default: "email", null: false
    t.string   "uid"
    t.json     "tokens"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "account_id",                            null: false
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "values", force: :cascade do |t|
    t.json     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "entry_id"
    t.integer  "field_id",   null: false
  end

  add_index "values", ["entry_id", "field_id"], name: "index_values_on_entry_id_and_field_id", unique: true, using: :btree
  add_index "values", ["entry_id"], name: "index_values_on_entry_id", using: :btree
  add_index "values", ["field_id"], name: "index_values_on_field_id", using: :btree

  add_foreign_key "attachments", "\"values\"", column: "value_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "entries", "storages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "fields", "storages", on_update: :cascade, on_delete: :cascade
  add_foreign_key "storages", "accounts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "accounts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "values", "entries", on_update: :cascade, on_delete: :cascade
  add_foreign_key "values", "fields", on_update: :cascade, on_delete: :cascade
end
