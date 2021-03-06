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

ActiveRecord::Schema.define(version: 2019_06_03_112152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.string "show_name", null: false
    t.string "booking_type", null: false
    t.json "user_info", default: {}
    t.datetime "test_date"
    t.datetime "recording_date"
    t.json "hardware_requirements", default: {}
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "province"
    t.string "postal_code"
    t.string "email"
    t.string "phone"
    t.string "fax"
    t.text "release"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "media_files", force: :cascade do |t|
    t.string "title"
    t.string "audio_link"
    t.string "video_link"
    t.boolean "is_approved", default: false
    t.text "edit"
    t.bigint "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_media_files_on_booking_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.string "phone", null: false
    t.string "password_digest", null: false
    t.json "social_media", default: "[]"
    t.json "company_social_media", default: "[]"
    t.string "role", default: "customer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "signed_release", default: false
    t.string "name_for_show"
    t.string "title_for_show"
    t.text "bio"
    t.string "company_name"
    t.boolean "profile_done", default: false
    t.date "dob"
    t.string "company_legal_name"
    t.string "company_phone"
    t.string "company_address1"
    t.string "company_address2"
    t.string "company_city"
    t.string "company_province"
    t.string "company_postalcode"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "company_country"
    t.index ["email"], name: "index_users_on_email"
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["phone"], name: "index_users_on_phone"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "users"
  add_foreign_key "media_files", "bookings"
end
