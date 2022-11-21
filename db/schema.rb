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

ActiveRecord::Schema.define(version: 20150925080242) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounting_accounts", force: :cascade do |t|
    t.integer  "account_number"
    t.string   "name"
    t.string   "invoice_type"
    t.string   "subcount1"
    t.string   "subcount2"
    t.string   "ap"
    t.string   "subcount3"
    t.integer  "parent_id"
    t.boolean  "directory",      default: false
    t.datetime "deleted_at"
  end

  add_index "accounting_accounts", ["deleted_at"], name: "index_accounting_accounts_on_deleted_at", using: :btree

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "account_type"
    t.integer  "number"
    t.string   "currency"
    t.integer  "bank_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "accounts", ["deleted_at"], name: "index_accounts_on_deleted_at", using: :btree

  create_table "articles", force: :cascade do |t|
    t.integer "code"
    t.string  "name"
  end

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "company_id"
    t.string  "account"
    t.string  "mfo"
    t.integer "bank_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string  "name"
    t.integer "code_edrpo"
    t.integer "mfo"
    t.string  "lawyer_adress"
  end

  create_table "cashiers", force: :cascade do |t|
    t.string   "name"
    t.string   "currency"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer  "chat_id"
    t.integer  "sender_id"
    t.text     "message_text"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "chats", force: :cascade do |t|
    t.string   "participants_key"
    t.string   "name"
    t.boolean  "in_group",         default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "full_name"
    t.string "short_name"
    t.string "latin_name"
    t.string "juridical_address"
    t.string "actual_address"
    t.string "numbering_format"
    t.string "state"
  end

  create_table "contracts", force: :cascade do |t|
    t.date     "date"
    t.string   "number"
    t.string   "contract_type"
    t.date     "validity"
    t.integer  "counterparty_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "contracts", ["deleted_at"], name: "index_contracts_on_deleted_at", using: :btree

  create_table "counterparties", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "title"
    t.boolean  "resident"
    t.string   "edrpo"
    t.string   "adress"
    t.string   "account"
    t.integer  "bank_id"
    t.integer  "mfo"
    t.datetime "deleted_at"
  end

  add_index "counterparties", ["deleted_at"], name: "index_counterparties_on_deleted_at", using: :btree

  create_table "credits", force: :cascade do |t|
    t.string  "name"
    t.string  "credit_type"
    t.string  "account_number"
    t.integer "bank_id"
    t.integer "company_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currency_transactions", force: :cascade do |t|
    t.datetime "date"
    t.integer  "order_id"
    t.float    "total_pf"
    t.integer  "company_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "departments", ["company_id"], name: "index_departments_on_company_id", using: :btree
  add_index "departments", ["deleted_at"], name: "index_departments_on_deleted_at", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "personnel_number"
    t.string   "type"
    t.string   "name"
    t.string   "passport"
    t.string   "adress"
    t.date     "date_birth"
    t.string   "ipn"
    t.integer  "department_id"
    t.integer  "position_id"
    t.integer  "company_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
  end

  add_index "employees", ["company_id"], name: "index_employees_on_company_id", using: :btree
  add_index "employees", ["deleted_at"], name: "index_employees_on_deleted_at", using: :btree
  add_index "employees", ["department_id"], name: "index_employees_on_department_id", using: :btree
  add_index "employees", ["position_id"], name: "index_employees_on_position_id", using: :btree

  create_table "guide_units", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "guide_units", ["deleted_at"], name: "index_guide_units_on_deleted_at", using: :btree

  create_table "incorporation_forms", force: :cascade do |t|
    t.integer "number"
    t.string  "name"
  end

  create_table "koatuus", force: :cascade do |t|
    t.string "code"
    t.string "name"
  end

  create_table "kveds", force: :cascade do |t|
    t.string "section"
    t.string "number"
    t.string "name"
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id", using: :btree
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type", using: :btree

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id", using: :btree
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type", using: :btree
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type", using: :btree
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type", using: :btree

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id", using: :btree
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type", using: :btree

  create_table "main_tools", force: :cascade do |t|
    t.string   "title"
    t.string   "type"
    t.string   "serial_number"
    t.string   "passport_number"
    t.date     "date"
    t.string   "brand"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "money_registers", force: :cascade do |t|
    t.date     "date"
    t.string   "type_document"
    t.integer  "counterparty_id"
    t.integer  "contract_id"
    t.integer  "account_id"
    t.float    "total"
    t.integer  "article_id"
    t.integer  "company_id"
    t.string   "type_money"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nomenclatures", force: :cascade do |t|
    t.string   "title"
    t.string   "type"
    t.integer  "guide_unit_id"
    t.integer  "accounting_account_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "count"
  end

  add_index "nomenclatures", ["accounting_account_id"], name: "index_nomenclatures_on_accounting_account_id", using: :btree
  add_index "nomenclatures", ["company_id"], name: "index_nomenclatures_on_company_id", using: :btree
  add_index "nomenclatures", ["guide_unit_id"], name: "index_nomenclatures_on_guide_unit_id", using: :btree

  create_table "officials", force: :cascade do |t|
    t.integer "company_id"
    t.string  "official_type"
    t.string  "name"
    t.string  "tin"
    t.string  "phone"
    t.string  "email"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "date"
    t.integer  "bank_id"
    t.string   "currency"
    t.float    "total"
    t.float    "total_grn"
    t.float    "rate"
    t.float    "commission"
    t.integer  "account_grn_id"
    t.integer  "account_rate_id"
    t.integer  "company_id"
    t.string   "type_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree

  create_table "participants", force: :cascade do |t|
    t.integer  "chat_id"
    t.integer  "participant_id"
    t.boolean  "existing"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "payment_orders", force: :cascade do |t|
    t.datetime "date"
    t.integer  "account_id"
    t.integer  "counterparty_id"
    t.float    "total"
    t.integer  "article_id"
    t.string   "type_order"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "currency"
  end

  create_table "positions", force: :cascade do |t|
    t.string   "title"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positions", ["company_id"], name: "index_positions_on_company_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.integer  "number"
    t.integer  "amount"
    t.float    "price"
    t.float    "total"
    t.date     "date"
    t.date     "document_date"
    t.boolean  "conducted",       default: false
    t.string   "title"
    t.string   "document_type"
    t.string   "document_number"
    t.string   "currency"
    t.integer  "guide_unit_id"
    t.integer  "counterparty_id"
    t.integer  "department_id"
    t.integer  "company_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "products", ["company_id"], name: "index_products_on_company_id", using: :btree
  add_index "products", ["counterparty_id"], name: "index_products_on_counterparty_id", using: :btree
  add_index "products", ["department_id"], name: "index_products_on_department_id", using: :btree
  add_index "products", ["guide_unit_id"], name: "index_products_on_guide_unit_id", using: :btree

  create_table "recipients", force: :cascade do |t|
    t.integer  "chat_message_id"
    t.integer  "recipient_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "registrations", force: :cascade do |t|
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

  create_table "tax_inspections", force: :cascade do |t|
    t.string "name"
  end

  create_table "user_companies", force: :cascade do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.boolean "current_company"
    t.string  "role"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "activate_token"
    t.boolean  "is_admin",               default: false
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "password_digest"
  end

  add_foreign_key "mailboxer_conversation_opt_outs", "mailboxer_conversations", column: "conversation_id", name: "mb_opt_outs_on_conversations_id"
  add_foreign_key "mailboxer_notifications", "mailboxer_conversations", column: "conversation_id", name: "notifications_on_conversation_id"
  add_foreign_key "mailboxer_receipts", "mailboxer_notifications", column: "notification_id", name: "receipts_on_notification_id"
end
