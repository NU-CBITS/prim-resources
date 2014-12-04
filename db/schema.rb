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

ActiveRecord::Schema.define(version: 20141204160805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "name"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "primary"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["participant_id"], name: "index_addresses_on_participant_id", using: :btree

  create_table "api_consumers", force: true do |t|
    t.string   "name",            null: false
    t.string   "token_salt",      null: false
    t.string   "encrypted_token", null: false
    t.string   "ip_address",      null: false
    t.integer  "project_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "date_of_births", force: true do |t|
    t.date     "date_of_birth"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "date_of_births", ["participant_id"], name: "index_date_of_births_on_participant_id", using: :btree

  create_table "emails", force: true do |t|
    t.string   "email"
    t.boolean  "primary"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "emails", ["participant_id"], name: "index_emails_on_participant_id", using: :btree

  create_table "health_insurance_beneficiary_numbers", force: true do |t|
    t.string   "number"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "health_insurance_beneficiary_numbers", ["participant_id"], name: "index_health_insurance_beneficiary_numbers_on_participant_id", using: :btree

  create_table "ip_address_numbers", force: true do |t|
    t.string   "number"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ip_address_numbers", ["participant_id"], name: "index_ip_address_numbers_on_participant_id", using: :btree

  create_table "medical_record_numbers", force: true do |t|
    t.string   "number"
    t.string   "name"
    t.string   "description"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "medical_record_numbers", ["participant_id"], name: "index_medical_record_numbers_on_participant_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "project_id",     null: false
    t.integer  "participant_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "memberships", ["project_id", "participant_id"], name: "index_memberships_on_project_id_and_participant_id", unique: true, using: :btree

  create_table "names", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "prefix"
    t.string   "suffix"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "names", ["participant_id"], name: "index_names_on_participant_id", using: :btree

  create_table "participants", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "external_id"
  end

  add_index "participants", ["external_id"], name: "index_participants_on_external_id", using: :btree

  create_table "phones", force: true do |t|
    t.string   "name"
    t.string   "number"
    t.boolean  "primary"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phones", ["participant_id"], name: "index_phones_on_participant_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["name"], name: "index_projects_on_name", unique: true, using: :btree

  create_table "screenings", force: true do |t|
    t.integer "site_id"
    t.integer "participant_id"
    t.string  "question"
    t.string  "answer"
    t.integer "position"
  end

  add_index "screenings", ["participant_id"], name: "index_screenings_on_participant_id", using: :btree

  create_table "social_security_numbers", force: true do |t|
    t.string   "number"
    t.integer  "participant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "social_security_numbers", ["participant_id"], name: "index_social_security_numbers_on_participant_id", using: :btree

  create_table "statuses", force: true do |t|
    t.integer "participant_id"
    t.integer "site_id"
    t.string  "name"
    t.string  "description"
    t.boolean "final"
  end

  add_index "statuses", ["participant_id"], name: "index_statuses_on_participant_id", using: :btree

end
