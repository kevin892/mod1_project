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

ActiveRecord::Schema.define(version: 4) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.text "name"
    t.datetime "payment_process_date"
    t.integer "amount"
    t.string "subscription_type"
    t.integer "customer_id"
    t.integer "company_id"
    t.index ["company_id"], name: "index_subscriptions_on_company_id"
    t.index ["customer_id"], name: "index_subscriptions_on_customer_id"
  end

end
