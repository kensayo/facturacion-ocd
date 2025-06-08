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

ActiveRecord::Schema[8.0].define(version: 2025_05_09_026205) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.float "balance"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "currency_id"
    t.bigint "house_id"
    t.index ["code", "house_id"], name: "index_accounts_on_code_and_house_id", unique: true
    t.index ["currency_id"], name: "index_accounts_on_currency_id"
    t.index ["house_id"], name: "index_accounts_on_house_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "symbol"
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "houses", force: :cascade do |t|
    t.string "state"
    t.string "name"
    t.string "shortname"
    t.string "address"
    t.string "city"
    t.string "country"
    t.string "email"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_houses_on_code", unique: true
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_transaction_types_on_code", unique: true
    t.index ["name"], name: "index_transaction_types_on_name", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.float "amount"
    t.date "date"
    t.string "description"
    t.text "details"
    t.float "exchange_rate"
    t.string "invoice_number"
    t.boolean "is_income", default: true
    t.bigint "account_id"
    t.bigint "user_id"
    t.bigint "transaction_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "username"
    t.text "name"
    t.text "lastname"
    t.date "birthdate"
    t.string "user_role"
    t.string "remember_digest"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "house_id"
    t.index ["house_id"], name: "index_users_on_house_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "accounts", "currencies"
  add_foreign_key "accounts", "houses"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "transaction_types"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "houses"
end
