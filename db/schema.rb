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

ActiveRecord::Schema[7.0].define(version: 2023_07_23_104933) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.string "number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_clients_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.string "city"
    t.string "country"
    t.string "website"
    t.string "type"
    t.string "subscription"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parts", force: :cascade do |t|
    t.string "part_number", null: false
    t.string "description", null: false
    t.integer "available", default: 0, null: false
    t.integer "reserved", default: 0, null: false
    t.integer "sold", default: 0, null: false
    t.string "condition", null: false
    t.decimal "min_cost", precision: 15, scale: 3, default: "0.0"
    t.decimal "min_price", precision: 15, scale: 3, default: "0.0"
    t.integer "min_order", default: 0
    t.decimal "med_cost", precision: 15, scale: 3, default: "0.0"
    t.decimal "med_price", precision: 15, scale: 3, default: "0.0"
    t.integer "med_order", default: 0
    t.decimal "max_cost", precision: 15, scale: 3, default: "0.0"
    t.decimal "max_price", precision: 15, scale: 3, default: "0.0"
    t.integer "max_order", default: 0
    t.string "lead_time"
    t.string "quote_type"
    t.string "tag", null: false
    t.date "added", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_parts_on_company_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.boolean "admin", default: false, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
