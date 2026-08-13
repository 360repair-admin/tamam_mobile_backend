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

ActiveRecord::Schema[8.1].define(version: 2026_08_12_132137) do
  create_table "addresses", force: :cascade do |t|
    t.string "address_line"
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.integer "customer_id", null: false
    t.boolean "is_default", default: false, null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
  end

  create_table "cities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.integer "region_id", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.string "locale", default: "ar", null: false
    t.string "phone_number", null: false
    t.datetime "phone_number_verified_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_customers_on_phone_number", unique: true
  end

  create_table "otp_requests", force: :cascade do |t|
    t.integer "attempts"
    t.string "code_digest"
    t.datetime "consumed_at"
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.string "phone_number"
    t.string "purpose"
    t.string "request_id"
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "code"
    t.integer "country_id", null: false
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "customers"
  add_foreign_key "cities", "regions"
  add_foreign_key "regions", "countries"
end
