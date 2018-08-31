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

ActiveRecord::Schema.define(version: 2018_08_31_161921) do

  create_table "active_books", force: :cascade do |t|
    t.integer "member_id"
    t.integer "driver_id"
    t.integer "status_id"
    t.decimal "src_lat"
    t.decimal "src_long"
    t.decimal "dest_lat"
    t.decimal "dest_long"
    t.integer "price"
    t.string "from"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_active_books_on_driver_id"
    t.index ["member_id"], name: "index_active_books_on_member_id"
    t.index ["status_id"], name: "index_active_books_on_status_id"
  end

  create_table "book_histories", force: :cascade do |t|
    t.integer "member_id"
    t.integer "driver_id"
    t.decimal "src_lat"
    t.decimal "src_long"
    t.decimal "dest_lat"
    t.decimal "dest_long"
    t.integer "price"
    t.string "from"
    t.string "to"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_book_histories_on_driver_id"
    t.index ["member_id"], name: "index_book_histories_on_member_id"
  end

  create_table "driver_details", force: :cascade do |t|
    t.decimal "curr_lat"
    t.decimal "curr_long"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "driver_id"
    t.index ["driver_id"], name: "index_driver_details_on_driver_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.datetime "birthdate"
    t.string "license_plate"
    t.decimal "rating"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.string "license_number"
    t.string "ktp_number"
    t.string "address"
    t.integer "income"
    t.index ["email"], name: "index_drivers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true
  end

  create_table "member_details", force: :cascade do |t|
    t.decimal "curr_lat"
    t.decimal "curr_long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "member_id"
    t.index ["member_id"], name: "index_member_details_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone_number"
    t.integer "go_pay_value"
    t.integer "go_point_value"
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "status"
  end

end
