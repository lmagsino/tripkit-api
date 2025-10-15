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

ActiveRecord::Schema[7.1].define(version: 2025_10_15_014556) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "documents", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.string "document_type", null: false
    t.string "title", null: false
    t.text "notes"
    t.bigint "uploaded_by_user_id", null: false
    t.datetime "uploaded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_type"], name: "index_documents_on_document_type"
    t.index ["trip_id"], name: "index_documents_on_trip_id"
    t.index ["uploaded_by_user_id"], name: "index_documents_on_uploaded_by_user_id"
  end

  create_table "expense_splits", force: :cascade do |t|
    t.bigint "expense_id", null: false
    t.bigint "user_id", null: false
    t.decimal "share_amount", precision: 10, scale: 2, null: false
    t.boolean "paid", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id", "user_id"], name: "index_expense_splits_on_expense_id_and_user_id", unique: true
    t.index ["expense_id"], name: "index_expense_splits_on_expense_id"
    t.index ["user_id"], name: "index_expense_splits_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.decimal "amount", precision: 10, scale: 2, null: false
    t.string "currency", null: false
    t.string "category", null: false
    t.text "description"
    t.bigint "paid_by_user_id", null: false
    t.string "split_type", default: "equal", null: false
    t.date "expense_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_expenses_on_category"
    t.index ["expense_date"], name: "index_expenses_on_expense_date"
    t.index ["paid_by_user_id"], name: "index_expenses_on_paid_by_user_id"
    t.index ["trip_id"], name: "index_expenses_on_trip_id"
  end

  create_table "itinerary_items", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.date "date", null: false
    t.time "time"
    t.string "title", null: false
    t.string "location"
    t.text "notes"
    t.string "category", default: "activity", null: false
    t.bigint "created_by_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_itinerary_items_on_category"
    t.index ["created_by_user_id"], name: "index_itinerary_items_on_created_by_user_id"
    t.index ["date"], name: "index_itinerary_items_on_date"
    t.index ["trip_id"], name: "index_itinerary_items_on_trip_id"
  end

  create_table "trip_memberships", force: :cascade do |t|
    t.bigint "trip_id", null: false
    t.bigint "user_id", null: false
    t.string "role", default: "member", null: false
    t.datetime "joined_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id", "user_id"], name: "index_trip_memberships_on_trip_id_and_user_id", unique: true
    t.index ["trip_id"], name: "index_trip_memberships_on_trip_id"
    t.index ["user_id"], name: "index_trip_memberships_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.string "base_currency", default: "PHP", null: false
    t.string "active_currency", default: "PHP", null: false
    t.decimal "total_budget", precision: 10, scale: 2
    t.string "invite_code", null: false
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_trips_on_creator_id"
    t.index ["invite_code"], name: "index_trips_on_invite_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "documents", "trips"
  add_foreign_key "documents", "users", column: "uploaded_by_user_id"
  add_foreign_key "expense_splits", "expenses"
  add_foreign_key "expense_splits", "users"
  add_foreign_key "expenses", "trips"
  add_foreign_key "expenses", "users", column: "paid_by_user_id"
  add_foreign_key "itinerary_items", "trips"
  add_foreign_key "itinerary_items", "users", column: "created_by_user_id"
  add_foreign_key "trip_memberships", "trips"
  add_foreign_key "trip_memberships", "users"
  add_foreign_key "trips", "users", column: "creator_id"
end
