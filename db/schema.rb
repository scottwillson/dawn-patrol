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

ActiveRecord::Schema.define(version: 20160921152438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculations_calculations", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id",                                            null: false
    t.decimal  "dnf_points",                 precision: 10, default: 0,                 null: false
    t.string   "name",                                      default: "New Calculation", null: false
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.index ["dawn_patrol_association_id"], name: "index_calculations_calculations_on_dawn_patrol_association_id", using: :btree
  end

  create_table "calculations_rejections", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id", null: false
    t.integer  "event_id",                   null: false
    t.integer  "result_id",                  null: false
    t.string   "reason"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["dawn_patrol_association_id"], name: "index_calculations_rejections_on_dawn_patrol_association_id", using: :btree
    t.index ["event_id", "result_id"], name: "index_calculations_rejections_on_event_id_and_result_id", unique: true, using: :btree
    t.index ["event_id"], name: "index_calculations_rejections_on_event_id", using: :btree
    t.index ["result_id"], name: "index_calculations_rejections_on_result_id", using: :btree
  end

  create_table "calculations_selections", force: :cascade do |t|
    t.integer  "calculated_result_id",                                  null: false
    t.integer  "dawn_patrol_association_id",                            null: false
    t.decimal  "points",                     precision: 10, default: 0, null: false
    t.integer  "source_result_id",                                      null: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.index ["calculated_result_id", "source_result_id"], name: "index_calculations_selections_calculated_result_source_result", unique: true, using: :btree
    t.index ["calculated_result_id"], name: "index_calculations_selections_on_calculated_result_id", using: :btree
    t.index ["dawn_patrol_association_id"], name: "index_calculations_selections_on_dawn_patrol_association_id", using: :btree
    t.index ["source_result_id"], name: "index_calculations_selections_on_source_result_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id",                          null: false
    t.string   "name",                       default: "New Category", null: false
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["dawn_patrol_association_id", "name"], name: "index_categories_on_dawn_patrol_association_id_and_name", unique: true, using: :btree
    t.index ["dawn_patrol_association_id"], name: "index_categories_on_dawn_patrol_association_id", using: :btree
  end

  create_table "dawn_patrol_associations", force: :cascade do |t|
    t.string   "acronym",    default: "CBRA",                                      null: false
    t.string   "host",       default: "localhost|0.0.0.0|127.0.0.1|::1|test.host", null: false
    t.string   "name",       default: "Cascadia Bicycle Racing Association",       null: false
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.integer  "position"
    t.index ["acronym"], name: "index_dawn_patrol_associations_on_acronym", unique: true, using: :btree
    t.index ["host"], name: "index_dawn_patrol_associations_on_host", unique: true, using: :btree
    t.index ["name"], name: "index_dawn_patrol_associations_on_name", unique: true, using: :btree
  end

  create_table "disciplines", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id",                  null: false
    t.string   "name",                       default: "Road", null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.index ["dawn_patrol_association_id", "name"], name: "index_disciplines_on_dawn_patrol_association_id_and_name", unique: true, using: :btree
    t.index ["dawn_patrol_association_id"], name: "index_disciplines_on_dawn_patrol_association_id", using: :btree
  end

  create_table "events_categories", force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "dawn_patrol_association_id", null: false
    t.integer  "event_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["category_id", "event_id"], name: "index_events_categories_on_category_id_and_event_id", using: :btree
    t.index ["category_id"], name: "index_events_categories_on_category_id", using: :btree
    t.index ["dawn_patrol_association_id"], name: "index_events_categories_on_dawn_patrol_association_id", using: :btree
    t.index ["event_id"], name: "index_events_categories_on_event_id", using: :btree
  end

  create_table "events_events", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id",                       null: false
    t.integer  "discipline_id",                                    null: false
    t.integer  "calculation_id"
    t.datetime "starts_at",                                        null: false
    t.string   "city"
    t.string   "name",                       default: "New Event", null: false
    t.integer  "racing_on_rails_id"
    t.string   "phone"
    t.string   "state"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.index ["calculation_id"], name: "index_events_events_on_calculation_id", using: :btree
    t.index ["dawn_patrol_association_id"], name: "index_events_events_on_dawn_patrol_association_id", using: :btree
    t.index ["discipline_id"], name: "index_events_events_on_discipline_id", using: :btree
    t.index ["name"], name: "index_events_events_on_name", using: :btree
    t.index ["starts_at"], name: "index_events_events_on_starts_at", using: :btree
  end

  create_table "events_promoters", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id", null: false
    t.integer  "event_id",                   null: false
    t.integer  "person_id",                  null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["dawn_patrol_association_id"], name: "index_events_promoters_on_dawn_patrol_association_id", using: :btree
    t.index ["event_id", "person_id"], name: "index_events_promoters_on_event_id_and_person_id", unique: true, using: :btree
    t.index ["event_id"], name: "index_events_promoters_on_event_id", using: :btree
    t.index ["person_id"], name: "index_events_promoters_on_person_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id", null: false
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["dawn_patrol_association_id"], name: "index_people_on_dawn_patrol_association_id", using: :btree
    t.index ["name"], name: "index_people_on_name", using: :btree
  end

  create_table "results", force: :cascade do |t|
    t.integer  "dawn_patrol_association_id",                             null: false
    t.integer  "event_category_id"
    t.integer  "person_id"
    t.string   "place",                                     default: "", null: false
    t.decimal  "points",                     precision: 10, default: 0,  null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["dawn_patrol_association_id"], name: "index_results_on_dawn_patrol_association_id", using: :btree
    t.index ["event_category_id"], name: "index_results_on_event_category_id", using: :btree
    t.index ["person_id"], name: "index_results_on_person_id", using: :btree
  end

end
