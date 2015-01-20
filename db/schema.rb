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

ActiveRecord::Schema.define(version: 20150119075153) do

  create_table "articles_cash_flows", force: true do |t|
    t.integer "code"
    t.string  "name"
  end

  create_table "bank_accounts", force: true do |t|
    t.integer "company_id"
    t.string  "account"
    t.text    "bank"
    t.string  "mfo"
  end

  create_table "banks", force: true do |t|
    t.string  "name"
    t.integer "code_edrpo"
    t.integer "mfo"
    t.string  "lawyer_adress"
  end

  create_table "companies", force: true do |t|
    t.string "full_name"
    t.string "short_name"
    t.string "latin_name"
    t.string "juridical_address"
    t.string "actual_address"
    t.string "numbering_format"
    t.string "state"
  end

  create_table "counterparties", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "credits", force: true do |t|
    t.string  "name"
    t.string  "credit_type"
    t.string  "account_number"
    t.integer "bank_id"
    t.integer "company_id"
  end

  create_table "currencies", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incorporation_forms", force: true do |t|
    t.integer "number"
    t.string  "name"
  end

  create_table "invoice_forms", force: true do |t|
    t.integer "account_number"
    t.string  "name"
    t.string  "invoice_type"
    t.string  "subcount1"
    t.string  "subcount2"
  end

  create_table "koatuus", force: true do |t|
    t.string "code"
    t.string "name"
  end

  create_table "kveds", force: true do |t|
    t.string "section"
    t.string "number"
    t.string "name"
  end

  create_table "officials", force: true do |t|
    t.integer "company_id"
    t.string  "official_type"
    t.string  "name"
    t.string  "tin"
    t.string  "phone"
    t.string  "email"
  end

  create_table "registers", force: true do |t|
    t.date     "date"
    t.integer  "counterparty_id"
    t.string   "operations"
    t.integer  "value"
    t.boolean  "holding"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "registrations", force: true do |t|
    t.integer "company_id"
    t.string  "form_of_incorporation"
    t.string  "legal_form_code"
    t.string  "edrpou"
    t.string  "nace_codes"
    t.string  "koatuu"
    t.integer "risk_class"
    t.string  "tin"
    t.date    "state_registration_date"
    t.string  "registration_number"
    t.string  "registered_by"
    t.date    "date_registered_in_revenue_commissioners"
    t.string  "number_registered_in_revenue_commissioners"
    t.date    "registered_in_pension_fund"
    t.string  "code_registered_in_pension_fund"
    t.string  "tax_system"
    t.boolean "pdv"
    t.string  "tax_inspection"
  end

  create_table "tax_inspections", force: true do |t|
    t.string "name"
  end

  create_table "user_companies", force: true do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.boolean "current_company"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password"
    t.string   "confirm_password"
    t.string   "activate_token"
    t.boolean  "is_admin",               default: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "role"
  end

end
