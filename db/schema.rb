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

ActiveRecord::Schema.define(version: 2020_01_12_153346) do

  create_table "abbrevations", force: :cascade do |t|
    t.string "abbrev"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consultations", force: :cascade do |t|
    t.text "content"
    t.text "diagnosis"
    t.integer "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date", null: false
    t.index ["patient_id", "created_at"], name: "index_consultations_on_patient_id_and_created_at"
    t.index ["patient_id"], name: "index_consultations_on_patient_id"
  end

  create_table "entry_lines", force: :cascade do |t|
    t.integer "invoice_id"
    t.text "text"
    t.float "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount"
    t.index ["invoice_id"], name: "index_entry_lines_on_invoice_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "patient_id"
    t.text "diagnosis"
    t.float "totalfee"
    t.string "invoicenumber", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.date "consultation_date", null: false
    t.index ["patient_id", "created_at"], name: "index_invoices_on_patient_id_and_created_at"
    t.index ["patient_id"], name: "index_invoices_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "street", null: false
    t.string "zip", null: false
    t.string "city", null: false
    t.date "birthdate", null: false
    t.string "email"
    t.string "phonenumber1"
    t.string "phonenumber2"
    t.string "insurance", null: false
    t.string "ssn", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "parent_id", null: false
    t.integer "patient_id", null: false
    t.boolean "primary_contact", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id", "patient_id"], name: "index_relationships_on_parent_id_and_patient_id", unique: true
    t.index ["parent_id"], name: "index_relationships_on_parent_id"
    t.index ["patient_id"], name: "index_relationships_on_patient_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "title"
    t.string "firstname"
    t.string "lastname"
    t.string "street"
    t.string "zip"
    t.string "city"
    t.string "email"
    t.string "phonenumber"
    t.integer "initial_invoicenumber"
    t.integer "current_invoicenumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "fullname", null: false
    t.string "email", null: false
    t.string "password_digest"
    t.integer "permissions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
