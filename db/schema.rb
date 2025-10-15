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

ActiveRecord::Schema[7.1].define(version: 2025_10_15_012745) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  add_foreign_key "expense_splits", "expenses"
  add_foreign_key "expense_splits", "users"
  add_foreign_key "expenses", "trips"
  add_foreign_key "expenses", "users", column: "paid_by_user_id"
  add_foreign_key "trip_memberships", "trips"
  add_foreign_key "trip_memberships", "users"
  add_foreign_key "trips", "users", column: "creator_id"
end
