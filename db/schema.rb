# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_07_24_213011) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "filaments", force: :cascade do |t|
    t.string "name", null: false
    t.integer "material_type", null: false
    t.string "color", null: false
    t.decimal "initial_weight", precision: 10, scale: 2, null: false
    t.decimal "purchase_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "brand", default: "", null: false
    t.decimal "price_per_gram", precision: 10, scale: 4
    t.bigint "user_id"
    t.index ["user_id"], name: "index_filaments_on_user_id"
  end

  create_table "printers", force: :cascade do |t|
    t.string "printer_brand"
    t.string "printer_model"
    t.string "printer_name"
    t.decimal "kilowatt_hour"
    t.string "printer_ip"
    t.string "serial"
    t.string "access_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_printers_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "category", null: false
    t.decimal "material_weight", precision: 10, scale: 2, null: false
    t.integer "production_time_seconds", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "filaments", "users"
  add_foreign_key "printers", "users"
  add_foreign_key "products", "users"
  add_foreign_key "sessions", "users"
end
