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

ActiveRecord::Schema.define(version: 20160705185919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dawn_patrol_associations", force: :cascade do |t|
    t.string   "acronym",    default: "CBRA",                                      null: false
    t.string   "host",       default: "localhost|0.0.0.0|127.0.0.1|::1|test.host", null: false
    t.string   "name",       default: "Cascadia Bicycle Racing Association",       null: false
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.index ["acronym"], name: "index_dawn_patrol_associations_on_acronym", using: :btree
  end

  create_table "events_events", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id", null: false
    t.datetime "starts_at"
    t.string   "discipline"
    t.string   "city"
    t.string   "name"
    t.string   "promoter_name"
    t.string   "phone"
    t.string   "state"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["dawn_patrol_association_id"], name: "index_events_events_on_dawn_patrol_association_id", using: :btree
    t.index ["name"], name: "index_events_events_on_name", using: :btree
    t.index ["starts_at"], name: "index_events_events_on_starts_at", using: :btree
  end

end
