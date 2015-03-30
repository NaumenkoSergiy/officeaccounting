# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150330082541) do

  create_table "accounting_accounts", force: :cascade do |t|
    t.integer "account_number", limit: 4
    t.string  "name",           limit: 255
    t.string  "invoice_type",   limit: 255
    t.string  "subcount1",      limit: 255
    t.string  "subcount2",      limit: 255
    t.string  "ap",             limit: 255
    t.string  "subcount3",      limit: 255
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "account_type", limit: 255
    t.integer  "number",       limit: 4
    t.string   "currency",     limit: 255
    t.integer  "bank_id",      limit: 4
    t.integer  "company_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "accounts", ["deleted_at"], name: "index_accounts_on_deleted_at", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer "code", limit: 4
    t.string  "name", limit: 255
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "company_id", limit: 4
    t.string  "account",    limit: 255
    t.string  "mfo",        limit: 255
    t.integer "bank_id",    limit: 4
  end

  create_table "banks", force: :cascade do |t|
    t.string  "name",          limit: 255
    t.integer "code_edrpo",    limit: 4
    t.integer "mfo",           limit: 4
    t.string  "lawyer_adress", limit: 255
  end

  create_table "cashiers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "currency",   limit: 255
    t.integer  "company_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string "full_name",         limit: 255
    t.string "short_name",        limit: 255
    t.string "latin_name",        limit: 255
    t.string "juridical_address", limit: 255
    t.string "actual_address",    limit: 255
    t.string "numbering_format",  limit: 255
    t.string "state",             limit: 255
  end

  create_table "contracts", force: :cascade do |t|
    t.date     "date"
    t.string   "number",          limit: 255
    t.string   "contract_type",   limit: 255
    t.date     "validity"
    t.integer  "counterparty_id", limit: 4
    t.integer  "company_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "contracts", ["deleted_at"], name: "index_contracts_on_deleted_at", using: :btree

  create_table "counterparties", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",     limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id", limit: 4
    t.string   "title",      limit: 255
    t.boolean  "resident",   limit: 1
    t.string   "edrpo",      limit: 255
    t.string   "adress",     limit: 255
    t.string   "account",    limit: 255
    t.integer  "bank_id",    limit: 4
    t.integer  "mfo",        limit: 4
    t.datetime "deleted_at"
  end

  add_index "counterparties", ["deleted_at"], name: "index_counterparties_on_deleted_at", using: :btree

  create_table "credits", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.string  "credit_type",    limit: 255
    t.string  "account_number", limit: 255
    t.integer "bank_id",        limit: 4
    t.integer "company_id",     limit: 4
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "company_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currency_transactions", force: :cascade do |t|
    t.datetime "date"
    t.integer  "order_id",   limit: 4
    t.float    "total_pf",   limit: 24
    t.integer  "company_id", limit: 4
    t.string   "type",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incorporation_forms", force: :cascade do |t|
    t.integer "number", limit: 4
    t.string  "name",   limit: 255
  end

  create_table "koatuus", force: :cascade do |t|
    t.string "code", limit: 255
    t.string "name", limit: 255
  end

  create_table "kveds", force: :cascade do |t|
    t.string "section", limit: 255
    t.string "number",  limit: 255
    t.string "name",    limit: 255
  end

  create_table "money_registers", force: :cascade do |t|
    t.date     "date"
    t.string   "type_document",   limit: 255
    t.integer  "counterparty_id", limit: 4
    t.integer  "contract_id",     limit: 4
    t.integer  "account_id",      limit: 4
    t.float    "total",           limit: 24
    t.integer  "article_id",      limit: 4
    t.integer  "company_id",      limit: 4
    t.string   "type_money",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "officials", force: :cascade do |t|
    t.integer "company_id",    limit: 4
    t.string  "official_type", limit: 255
    t.string  "name",          limit: 255
    t.string  "tin",           limit: 255
    t.string  "phone",         limit: 255
    t.string  "email",         limit: 255
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "date"
    t.integer  "bank_id",         limit: 4
    t.string   "currency",        limit: 255
    t.float    "total",           limit: 24
    t.float    "total_grn",       limit: 24
    t.float    "rate",            limit: 24
    t.float    "commission",      limit: 24
    t.integer  "account_grn_id",  limit: 4
    t.integer  "account_rate_id", limit: 4
    t.integer  "company_id",      limit: 4
    t.string   "type_order",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree

  create_table "payment_orders", force: :cascade do |t|
    t.datetime "date"
    t.integer  "account_id",      limit: 4
    t.integer  "counterparty_id", limit: 4
    t.float    "total",           limit: 24
    t.integer  "article_id",      limit: 4
    t.string   "type_order",      limit: 255
    t.integer  "company_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency",        limit: 255
  end

  create_table "registrations", force: :cascade do |t|
    t.integer "company_id",                                 limit: 4
    t.string  "form_of_incorporation",                      limit: 255
    t.string  "legal_form_code",                            limit: 255
    t.string  "edrpou",                                     limit: 255
    t.string  "nace_codes",                                 limit: 255
    t.string  "koatuu",                                     limit: 255
    t.integer "risk_class",                                 limit: 4
    t.string  "tin",                                        limit: 255
    t.date    "state_registration_date"
    t.string  "registration_number",                        limit: 255
    t.string  "registered_by",                              limit: 255
    t.date    "date_registered_in_revenue_commissioners"
    t.string  "number_registered_in_revenue_commissioners", limit: 255
    t.date    "registered_in_pension_fund"
    t.string  "code_registered_in_pension_fund",            limit: 255
    t.string  "tax_system",                                 limit: 255
    t.boolean "pdv",                                        limit: 1
    t.string  "tax_inspection",                             limit: 255
  end

  create_table "tax_inspections", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "user_companies", force: :cascade do |t|
    t.integer "company_id",      limit: 4
    t.integer "user_id",         limit: 4
    t.boolean "current_company", limit: 1
    t.string  "role",            limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "activate_token",         limit: 255
    t.boolean  "is_admin",               limit: 1,   default: false
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "password_digest",        limit: 255
  end

end
