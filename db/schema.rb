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

ActiveRecord::Schema.define(version: 2019_05_25_165534) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["member_id"], name: "index_friends_on_member_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "member_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["member_id"], name: "index_friendships_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "website_url", null: false
    t.string "url_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "website_contents", default: {}
    t.integer "friendships_count", default: 0
    t.index ["name"], name: "index_members_on_name"
    t.index ["url_key"], name: "index_members_on_url_key"
    t.index ["website_contents"], name: "index_members_on_website_contents", using: :gin
  end

  add_foreign_key "friends", "members"
  add_foreign_key "friends", "members", column: "friend_id"
  add_foreign_key "friendships", "members"
  add_foreign_key "friendships", "members", column: "friend_id"
end
