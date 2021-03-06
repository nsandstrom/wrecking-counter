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

ActiveRecord::Schema.define(version: 20170826184524) do

  create_table "calibration_codes", force: :cascade do |t|
    t.string   "owner",      limit: 255
    t.integer  "station_id", limit: 4
    t.integer  "code",       limit: 4
    t.boolean  "completed"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "rounds", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",                   default: false
    t.datetime "endtime",                                  null: false
    t.text     "score",      limit: 65535
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.datetime "starttime"
    t.integer  "stations",   limit: 4,     default: 15
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "score",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "stations", force: :cascade do |t|
    t.string   "location",      limit: 255
    t.integer  "team_id",       limit: 4
    t.integer  "boost",         limit: 4,   default: 100, null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.datetime "latest_com"
    t.boolean  "under_capture"
    t.integer  "reward",        limit: 4
  end

  add_index "stations", ["team_id"], name: "index_stations_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.integer  "score",             limit: 4,   default: 0, null: false
    t.string   "colour",            limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "short_name",        limit: 255
    t.string   "captured_stations", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "stations", "teams"
end
