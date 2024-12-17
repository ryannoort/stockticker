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

ActiveRecord::Schema[8.0].define(version: 2024_10_31_022445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "commodities", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_commodities_on_name", unique: true
  end

  create_table "commodity_adjustments", force: :cascade do |t|
    t.bigint "commodity_id", null: false
    t.integer "price_change", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commodity_id"], name: "index_commodity_adjustments_on_commodity_id"
  end

  create_table "commodity_ownerships", force: :cascade do |t|
    t.bigint "commodity_id", null: false
    t.bigint "user_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commodity_id"], name: "index_commodity_ownerships_on_commodity_id"
    t.index ["user_id"], name: "index_commodity_ownerships_on_user_id"
    t.check_constraint "quantity >= 0", name: "quantity_check"
  end

  create_table "commodity_transactions", force: :cascade do |t|
    t.bigint "commodity_id", null: false
    t.bigint "user_id", null: false
    t.integer "quantity", null: false
    t.integer "price", null: false
    t.string "transaction_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commodity_id"], name: "index_commodity_transactions_on_commodity_id"
    t.index ["user_id"], name: "index_commodity_transactions_on_user_id"
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

  add_foreign_key "commodity_adjustments", "commodities"
  add_foreign_key "commodity_ownerships", "commodities"
  add_foreign_key "commodity_ownerships", "users"
  add_foreign_key "commodity_transactions", "commodities"
  add_foreign_key "commodity_transactions", "users"
  add_foreign_key "sessions", "users"
end
