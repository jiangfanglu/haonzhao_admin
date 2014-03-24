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

ActiveRecord::Schema.define(version: 20140324080513) do

  create_table "admins", force: true do |t|
    t.string    "name",                      default: "",                    null: false
    t.string    "username",      limit: 150, default: "",                    null: false
    t.string    "email",         limit: 100, default: "",                    null: false
    t.string    "password",      limit: 100, default: "",                    null: false
    t.integer   "block",         limit: 1,   default: 0,                     null: false
    t.integer   "sendEmail",     limit: 1,   default: 0
    t.timestamp "registerDate",              default: '2014-02-01 00:00:00', null: false
    t.timestamp "lastvisitDate",             default: '2014-02-01 00:00:00', null: false
    t.string    "activation",    limit: 100, default: "",                    null: false
    t.text      "params",                                                    null: false
    t.timestamp "lastResetTime",             default: '2014-02-01 00:00:00', null: false
    t.integer   "resetCount",                default: 0,                     null: false
    t.string    "usertype",      limit: 45,                                  null: false
    t.integer   "thumbnail",                 default: 0
    t.string    "token"
    t.string    "salt"
  end

  add_index "admins", ["block"], name: "idx_block", using: :btree
  add_index "admins", ["email"], name: "email", using: :btree
  add_index "admins", ["name"], name: "idx_name", using: :btree
  add_index "admins", ["username"], name: "username", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

end
