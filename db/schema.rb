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

ActiveRecord::Schema.define(version: 20170101085307) do

  create_table "accounts", force: :cascade do |t|
    t.string   "post",                                 default: ""
    t.decimal  "salary",       precision: 8, scale: 2, default: 0.0
    t.datetime "joining_date"
    t.string   "working_plan"
    t.integer  "user_id"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "is_admin",          default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "address"
    t.string   "bank_name"
    t.string   "account_number"
    t.string   "nationality"
    t.string   "mobile"
    t.string   "home"
    t.string   "work"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
