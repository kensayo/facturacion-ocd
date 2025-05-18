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

ActiveRecord::Schema[8.0].define(version: 2025_05_07_022405) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.text "coin_type"
    t.float "amount"
    t.date "date"
    t.string "description"
    t.text "details"
    t.text "type"
    t.float "exchange_rate"
    t.bigint "house_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_expenses_on_house_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "state"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "username"
    t.text "name"
    t.text "lastname"
    t.date "birthdate"
    t.string "remember_digest"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "house_id"
    t.index ["house_id"], name: "index_users_on_house_id"
  end

  add_foreign_key "expenses", "houses"
  add_foreign_key "expenses", "users"
  add_foreign_key "users", "houses"
end
