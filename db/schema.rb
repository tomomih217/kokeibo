# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_08_16_064914) do

  create_table "children", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.integer "stage"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "payment_collections", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "child_id"
    t.datetime "paymented_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_auto", default: false
    t.index ["child_id"], name: "index_payment_collections_on_child_id"
  end

  create_table "payments", charset: "utf8mb4", force: :cascade do |t|
    t.string "item", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "payment_collection_id", null: false
    t.index ["payment_collection_id"], name: "index_payments_on_payment_collection_id"
  end

  create_table "plans", charset: "utf8mb4", force: :cascade do |t|
    t.string "item", null: false
    t.integer "amount", null: false
    t.integer "payment_day", null: false
    t.boolean "is_auto", default: false
    t.bigint "child_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_plans_on_child_id"
  end

  create_table "results", charset: "utf8mb4", force: :cascade do |t|
    t.integer "age", null: false
    t.string "nursery_school", null: false
    t.string "kindergarten", null: false
    t.string "primary_school", null: false
    t.string "junior_high_school", null: false
    t.string "high_school", null: false
    t.string "university", null: false
    t.integer "living_alone_funds", null: false
    t.bigint "child_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "from_age_for_nursery_school", default: 0
    t.index ["child_id"], name: "index_results_on_child_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
  end

  add_foreign_key "payments", "payment_collections"
  add_foreign_key "results", "children"
end
