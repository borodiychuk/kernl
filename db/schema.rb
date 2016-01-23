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

ActiveRecord::Schema.define(version: 20160123214913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "email",      null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "file_uid",               null: false
    t.string   "file_name",              null: false
    t.integer  "ordering",   default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "product_id",             null: false
  end

  add_index "images", ["product_id"], name: "index_images_on_product_id", using: :btree

  create_table "product_prices", force: :cascade do |t|
    t.integer  "amount"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "product_id",                         null: false
  end

  add_index "product_prices", ["price"], name: "index_product_prices_on_price", using: :btree
  add_index "product_prices", ["product_id", "amount"], name: "index_product_prices_on_product_id_and_amount", unique: true, using: :btree
  add_index "product_prices", ["product_id"], name: "index_product_prices_on_product_id", using: :btree

  create_table "product_variants", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "product_id", null: false
  end

  add_index "product_variants", ["name"], name: "index_product_variants_on_name", using: :btree
  add_index "product_variants", ["product_id", "name"], name: "index_product_variants_on_product_id_and_name", unique: true, using: :btree
  add_index "product_variants", ["product_id"], name: "index_product_variants_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.boolean  "enabled",     default: false, null: false
    t.string   "title",       default: "",    null: false
    t.string   "subtitle",    default: "",    null: false
    t.string   "number",      default: "",    null: false
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "project_id",                  null: false
  end

  add_index "products", ["enabled"], name: "index_products_on_enabled", using: :btree
  add_index "products", ["project_id"], name: "index_products_on_project_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id", null: false
  end

  add_index "projects", ["account_id"], name: "index_projects_on_account_id", using: :btree

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

  add_foreign_key "images", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_prices", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "product_variants", "products", on_update: :cascade, on_delete: :cascade
  add_foreign_key "products", "projects", on_update: :cascade, on_delete: :cascade
  add_foreign_key "projects", "accounts", on_update: :cascade, on_delete: :cascade
  add_foreign_key "users", "accounts", on_update: :cascade, on_delete: :cascade
end
