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

ActiveRecord::Schema[8.1].define(version: 2026_09_16_072341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "address_line"
    t.bigint "city_id", null: false
    t.datetime "created_at", null: false
    t.boolean "is_default", default: false, null: false
    t.string "label"
    t.decimal "latitude", precision: 10, scale: 7
    t.decimal "longitude", precision: 10, scale: 7
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "auth_sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at", null: false
    t.string "jti", null: false
    t.datetime "revoked_at"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_auth_sessions_on_user_id"
  end

  create_table "cities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.bigint "region_id", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_cities_on_region_id"
  end

  create_table "colors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "app_version"
    t.datetime "created_at", null: false
    t.string "device_id"
    t.datetime "last_seen_at"
    t.string "platform", null: false
    t.string "token", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "faulty_comments", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "author_type", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.bigint "faulty_error_id", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_faulty_comments_on_author_type_and_author_id"
    t.index ["faulty_error_id"], name: "index_faulty_comments_on_faulty_error_id"
  end

  create_table "faulty_errors", force: :cascade do |t|
    t.datetime "assigned_at", precision: nil
    t.bigint "assigned_by_id"
    t.string "assigned_by_type"
    t.bigint "assigned_to_id"
    t.string "assigned_to_type"
    t.datetime "created_at", null: false
    t.string "error_class", null: false
    t.string "fingerprint", null: false
    t.datetime "last_event_at", precision: nil, null: false
    t.string "message", default: "No message provided", null: false
    t.datetime "resolved_at", precision: nil
    t.bigint "resolved_by_id"
    t.string "resolved_by_type"
    t.string "status", default: "unresolved", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_by_type", "assigned_by_id"], name: "index_faulty_errors_on_assigned_by_type_and_assigned_by_id"
    t.index ["assigned_to_type", "assigned_to_id"], name: "index_faulty_errors_on_assigned_to_type_and_assigned_to_id"
    t.index ["fingerprint"], name: "index_faulty_errors_on_fingerprint", unique: true
    t.index ["resolved_by_type", "resolved_by_id"], name: "index_faulty_errors_on_resolved_by_type_and_resolved_by_id"
  end

  create_table "faulty_events", force: :cascade do |t|
    t.text "backtrace", null: false
    t.jsonb "code_snippet", default: {}
    t.jsonb "context", default: {}
    t.datetime "created_at", null: false
    t.bigint "faulty_error_id", null: false
    t.string "request_id"
    t.string "status", default: "unresolved", null: false
    t.datetime "updated_at", null: false
    t.index ["faulty_error_id"], name: "index_faulty_events_on_faulty_error_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "body_ar", null: false
    t.text "body_en", null: false
    t.datetime "created_at", null: false
    t.datetime "read_at"
    t.string "title_ar", null: false
    t.string "title_en", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
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
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_regions_on_country_id"
  end

  create_table "service_categories", force: :cascade do |t|
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.text "description_ar"
    t.text "description_en"
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
    t.index ["name_en"], name: "index_service_categories_on_name_en", unique: true
  end

  create_table "sms_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "failed_at"
    t.integer "failed_attempts", default: 0, null: false
    t.text "message", null: false
    t.string "phone_number", null: false
    t.string "sender_id", null: false
    t.datetime "sent_at"
    t.string "sms_provider", null: false
    t.bigint "sms_template_id"
    t.datetime "updated_at", null: false
    t.index ["sms_template_id"], name: "index_sms_messages_on_sms_template_id"
  end

  create_table "sms_templates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "message_body_ar", null: false
    t.text "message_body_en", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.boolean "system", default: false, null: false
    t.string "unique_name", null: false
    t.datetime "updated_at", null: false
    t.index ["unique_name"], name: "index_sms_templates_on_unique_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.string "email"
    t.string "locale", default: "ar", null: false
    t.string "name"
    t.string "password_digest"
    t.string "phone_number"
    t.datetime "phone_number_verified_at"
    t.datetime "terms_accepted_at"
    t.string "type", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

  create_table "vehicle_makes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_models", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name_ar", null: false
    t.string "name_en", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_make_id", null: false
    t.index ["vehicle_make_id", "name_ar"], name: "index_vehicle_models_on_vehicle_make_id_and_name_ar", unique: true
    t.index ["vehicle_make_id", "name_en"], name: "index_vehicle_models_on_vehicle_make_id_and_name_en", unique: true
    t.index ["vehicle_make_id"], name: "index_vehicle_models_on_vehicle_make_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "chassis_number"
    t.bigint "color_id", null: false
    t.datetime "created_at", null: false
    t.integer "manufacturing_year", null: false
    t.string "plate_left_letter", null: false
    t.string "plate_middle_letter", null: false
    t.string "plate_number", null: false
    t.string "plate_right_letter", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "vehicle_model_id", null: false
    t.index ["color_id"], name: "index_vehicles_on_color_id"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
    t.index ["vehicle_model_id"], name: "index_vehicles_on_vehicle_model_id"
  end

  add_foreign_key "addresses", "cities"
  add_foreign_key "addresses", "users"
  add_foreign_key "auth_sessions", "users"
  add_foreign_key "cities", "regions"
  add_foreign_key "devices", "users"
  add_foreign_key "faulty_comments", "faulty_errors"
  add_foreign_key "faulty_events", "faulty_errors"
  add_foreign_key "notifications", "users"
  add_foreign_key "regions", "countries"
  add_foreign_key "sms_messages", "sms_templates"
  add_foreign_key "vehicle_models", "vehicle_makes"
  add_foreign_key "vehicles", "colors"
  add_foreign_key "vehicles", "users"
  add_foreign_key "vehicles", "vehicle_models"
end
