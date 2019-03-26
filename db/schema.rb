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

ActiveRecord::Schema.define(version: 3) do

  create_table "events", force: :cascade do |t|
    t.text "name"
    t.text "url"
    t.datetime "sale_start_date"
    t.string "genre"
    t.integer "min_price"
  end

  create_table "venue_event", force: :cascade do |t|
    t.datetime "event_date"
    t.integer "venue_id"
    t.integer "event_id"
    t.index ["event_id"], name: "index_venue_event_on_event_id"
    t.index ["venue_id"], name: "index_venue_event_on_venue_id"
  end

  create_table "venues", force: :cascade do |t|
    t.text "name"
    t.text "parking_info"
    t.text "city"
    t.text "address"
  end

end
