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

ActiveRecord::Schema.define(version: 20141012131508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_address"
  end

  create_table "member_memberships", force: true do |t|
    t.integer "member_id",     null: false
    t.integer "membership_id", null: false
    t.boolean "primary"
  end

  create_table "members", force: true do |t|
    t.string   "first_name",                 null: false
    t.string   "last_name",                  null: false
    t.string   "email",                      null: false
    t.date     "birthdate"
    t.boolean  "active",      default: true, null: false
    t.string   "usat_number"
    t.integer  "gender"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "home_phone"
    t.string   "cell_phone"
  end

  create_table "memberships", force: true do |t|
    t.string  "category",                  null: false
    t.integer "year",                      null: false
    t.decimal "price_paid",                null: false
    t.date    "date_paid",                 null: false
    t.boolean "active",     default: true, null: false
    t.text    "notes"
  end

end
