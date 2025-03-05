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

ActiveRecord::Schema[8.0].define(version: 2025_03_04_042127) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bets", force: :cascade do |t|
    t.bigint "casino_table_id", null: false
    t.bigint "cryptocurrency_id", null: false
    t.string "bet_type"
    t.decimal "amount"
    t.decimal "odds"
    t.decimal "total_value"
    t.datetime "bet_time"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["casino_table_id"], name: "index_bets_on_casino_table_id"
    t.index ["cryptocurrency_id"], name: "index_bets_on_cryptocurrency_id"
  end

  create_table "casino_tables", force: :cascade do |t|
    t.bigint "gambler_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gambler_id"], name: "index_casino_tables_on_gambler_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cryptocurrencies", force: :cascade do |t|
    t.string "api_id"
    t.string "name"
    t.string "symbol"
    t.text "description"
    t.string "logo_url"
    t.string "website_url"
    t.decimal "current_price_usd"
    t.decimal "market_cap_usd"
    t.decimal "volume_24h_usd"
    t.decimal "price_change_24h"
    t.decimal "price_change_percentage_24h"
    t.integer "rank"
    t.datetime "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cryptocurrency_categories", force: :cascade do |t|
    t.bigint "cryptocurrency_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_cryptocurrency_categories_on_category_id"
    t.index ["cryptocurrency_id"], name: "index_cryptocurrency_categories_on_cryptocurrency_id"
  end

  create_table "gamblers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "bio"
    t.datetime "join_date"
    t.string "profile_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bets", "casino_tables"
  add_foreign_key "bets", "cryptocurrencies"
  add_foreign_key "casino_tables", "gamblers"
  add_foreign_key "cryptocurrency_categories", "categories"
  add_foreign_key "cryptocurrency_categories", "cryptocurrencies"
end
