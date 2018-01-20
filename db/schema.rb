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

ActiveRecord::Schema.define(version: 20180120213754) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_companies_on_location_id"
  end

  create_table "contract_categories", force: :cascade do |t|
    t.integer "contract_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_contract_categories_on_category_id"
    t.index ["contract_id"], name: "index_contract_categories_on_contract_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "venue_id"
    t.integer "user_id"
    t.string "type"
    t.integer "fee"
    t.date "opening_date"
    t.boolean "musical", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "assistant"
    t.index ["user_id"], name: "index_contracts_on_user_id"
    t.index ["venue_id"], name: "index_contracts_on_venue_id"
  end

  create_table "designers", force: :cascade do |t|
    t.string "name"
    t.integer "union_id"
    t.string "password"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_venues_on_company_id"
  end

end
