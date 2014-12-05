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

ActiveRecord::Schema.define(version: 20141126134906) do

  create_table "bank_accounts", force: true do |t|
    t.integer "company_id"
    t.integer "account"
    t.text    "bank"
    t.integer "mfo"
  end

  create_table "companies", force: true do |t|
    t.integer "user_id"
    t.string  "full_name"
    t.string  "short_name"
    t.string  "latin_name"
    t.string  "juridical_address"
    t.string  "actual_address"
    t.string  "numbering_format"
  end

  create_table "officials", force: true do |t|
    t.integer "company_id"
    t.string  "type"
    t.string  "name"
    t.integer "tin"
    t.string  "phone"
    t.string  "email"
  end

  create_table "registrations", force: true do |t|
    t.integer "company_id"
    t.string  "form_of_incorporation"
    t.string  "legal_form_code"
    t.string  "edrpou"
    t.string  "nace_codes"
    t.integer "koatuu"
    t.integer "risk_class"
    t.integer "tin"
    t.date    "state_registration_date"
    t.string  "registration_number"
    t.string  "registered_by"
    t.date    "date_registered_in_revenue_commissioners"
    t.string  "number_registered_in_revenue_commissioners"
    t.date    "registered_in_pension_fund"
    t.integer "code_registered_in_pension_fund"
    t.string  "tax_system"
  end

  create_table "users", force: true do |t|
    t.string  "email"
    t.string  "password"
    t.string  "confirm_password"
    t.boolean "profile_confirmed", default: false
  end

end
