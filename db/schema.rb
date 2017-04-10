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

ActiveRecord::Schema.define(version: 20170326221419) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bartenders", force: :cascade do |t|
  end

  create_table "cooks", force: :cascade do |t|
  end

  create_table "customer_order_drinks", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "drink_id"
    t.integer  "customer_order_id"
    t.index ["customer_order_id"], name: "index_customer_order_drinks_on_customer_order_id", using: :btree
    t.index ["drink_id"], name: "index_customer_order_drinks_on_drink_id", using: :btree
  end

  create_table "customer_order_foods", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "food_id"
    t.integer  "customer_order_id"
    t.index ["customer_order_id"], name: "index_customer_order_foods_on_customer_order_id", using: :btree
    t.index ["food_id"], name: "index_customer_order_foods_on_food_id", using: :btree
  end

  create_table "customer_order_part_drinks", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "drink_id"
    t.integer  "customer_order_part_id"
    t.index ["customer_order_part_id"], name: "index_customer_order_part_drinks_on_customer_order_part_id", using: :btree
    t.index ["drink_id"], name: "index_customer_order_part_drinks_on_drink_id", using: :btree
  end

  create_table "customer_order_part_foods", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "customer_order_part_id"
    t.integer  "food_id"
    t.index ["customer_order_part_id"], name: "index_customer_order_part_foods_on_customer_order_part_id", using: :btree
    t.index ["food_id"], name: "index_customer_order_part_foods_on_food_id", using: :btree
  end

  create_table "customer_order_parts", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "employee_id"
    t.integer  "customer_order_id"
    t.integer  "status"
    t.index ["customer_order_id"], name: "index_customer_order_parts_on_customer_order_id", using: :btree
    t.index ["employee_id"], name: "index_customer_order_parts_on_employee_id", using: :btree
  end

  create_table "customer_order_seats", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "customer_order_id"
    t.integer  "number_of_seat_id"
    t.index ["customer_order_id"], name: "index_customer_order_seats_on_customer_order_id", using: :btree
    t.index ["number_of_seat_id"], name: "index_customer_order_seats_on_number_of_seat_id", using: :btree
  end

  create_table "customer_orders", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status"
    t.datetime "order_time"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_customer_orders_on_customer_id", using: :btree
  end

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
    t.index ["confirmation_token"], name: "index_customers_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_customers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "drink_reviews", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "drink_id"
    t.integer  "review_id"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_drink_reviews_on_customer_id", using: :btree
    t.index ["drink_id"], name: "index_drink_reviews_on_drink_id", using: :btree
    t.index ["review_id"], name: "index_drink_reviews_on_review_id", using: :btree
  end

  create_table "drinks", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",         precision: 8, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "restaurant_id"
    t.index ["restaurant_id"], name: "index_drinks_on_restaurant_id", using: :btree
  end

  create_table "employee_reviews", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "employee_id"
    t.integer  "review_id"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_employee_reviews_on_customer_id", using: :btree
    t.index ["employee_id"], name: "index_employee_reviews_on_employee_id", using: :btree
    t.index ["review_id"], name: "index_employee_reviews_on_review_id", using: :btree
  end

  create_table "employee_shifts", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "employee_id"
    t.integer  "shift_id"
    t.integer  "seat_id"
    t.index ["employee_id"], name: "index_employee_shifts_on_employee_id", using: :btree
    t.index ["seat_id"], name: "index_employee_shifts_on_seat_id", using: :btree
    t.index ["shift_id"], name: "index_employee_shifts_on_shift_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "type"
    t.integer  "clothing_size"
    t.date     "birth_date"
    t.float    "shoe_size"
    t.integer  "manager_id"
    t.boolean  "password_changed",       default: false
    t.string   "speciality"
    t.index ["confirmation_token"], name: "index_employees_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_employees_on_email", unique: true, using: :btree
    t.index ["manager_id"], name: "index_employees_on_manager_id", using: :btree
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
  end

  create_table "food_reviews", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "food_id"
    t.integer  "review_id"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_food_reviews_on_customer_id", using: :btree
    t.index ["food_id"], name: "index_food_reviews_on_food_id", using: :btree
    t.index ["review_id"], name: "index_food_reviews_on_review_id", using: :btree
  end

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",         precision: 8, scale: 2
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "restaurant_id"
    t.integer  "food_type"
    t.index ["restaurant_id"], name: "index_foods_on_restaurant_id", using: :btree
  end

  create_table "friendships", force: :cascade do |t|
    t.string   "friendable_type"
    t.integer  "friendable_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "blocker_id"
    t.integer  "status"
  end

  create_table "locations", force: :cascade do |t|
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
    t.index ["confirmation_token"], name: "index_managers_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_managers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "number_of_seats", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "seat_id"
    t.integer  "seatstable"
    t.index ["seat_id"], name: "index_number_of_seats_on_seat_id", using: :btree
  end

  create_table "offer_items", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "offer_id"
    t.decimal  "price"
    t.integer  "order_item_id"
    t.index ["offer_id"], name: "index_offer_items_on_offer_id", using: :btree
    t.index ["order_item_id"], name: "index_offer_items_on_order_item_id", using: :btree
  end

  create_table "offers", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "provider_id"
    t.integer  "order_id"
    t.datetime "delivery_time"
    t.integer  "offer_state"
    t.index ["order_id"], name: "index_offers_on_order_id", using: :btree
    t.index ["provider_id"], name: "index_offers_on_provider_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.string   "item"
    t.decimal  "quantity"
    t.string   "unit_of_measure"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "order_id"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "restaurant_id"
    t.datetime "active_from"
    t.datetime "active_till"
    t.boolean  "order_active"
    t.index ["restaurant_id"], name: "index_orders_on_restaurant_id", using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
    t.boolean  "password_changed"
    t.index ["confirmation_token"], name: "index_providers_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_providers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_providers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "reservation_invitations", force: :cascade do |t|
    t.integer  "status",         default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "reservation_id"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_reservation_invitations_on_customer_id", using: :btree
    t.index ["reservation_id"], name: "index_reservation_invitations_on_reservation_id", using: :btree
  end

  create_table "reservation_orders", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "reservation_id"
    t.integer  "customer_order_id"
    t.index ["customer_order_id"], name: "index_reservation_orders_on_customer_order_id", using: :btree
    t.index ["reservation_id"], name: "index_reservation_orders_on_reservation_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "reserved_from"
    t.datetime "reserved_to"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "restaurant_id"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_reservations_on_customer_id", using: :btree
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id", using: :btree
  end

  create_table "reserved_tables", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "reservation_id"
    t.integer  "number_of_seat_id"
    t.index ["number_of_seat_id"], name: "index_reserved_tables_on_number_of_seat_id", using: :btree
    t.index ["reservation_id"], name: "index_reserved_tables_on_reservation_id", using: :btree
  end

  create_table "restaurant_locations", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "restaurant_id"
    t.integer  "location_id"
    t.index ["location_id"], name: "index_restaurant_locations_on_location_id", using: :btree
    t.index ["restaurant_id"], name: "index_restaurant_locations_on_restaurant_id", using: :btree
  end

  create_table "restaurant_providers", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "restaurant_id"
    t.integer  "provider_id"
    t.index ["provider_id"], name: "index_restaurant_providers_on_provider_id", using: :btree
    t.index ["restaurant_id"], name: "index_restaurant_providers_on_restaurant_id", using: :btree
  end

  create_table "restaurant_reviews", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "review_id"
    t.integer  "restaurant_id"
    t.integer  "customer_id"
    t.index ["customer_id"], name: "index_restaurant_reviews_on_customer_id", using: :btree
    t.index ["restaurant_id"], name: "index_restaurant_reviews_on_restaurant_id", using: :btree
    t.index ["review_id"], name: "index_restaurant_reviews_on_review_id", using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "manager_id"
    t.string   "category"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.index ["manager_id"], name: "index_restaurants_on_manager_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seats", force: :cascade do |t|
    t.string   "area"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "restaurant_id"
    t.index ["restaurant_id"], name: "index_seats_on_restaurant_id", using: :btree
  end

  create_table "serving_times", force: :cascade do |t|
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "employee_id"
    t.integer  "customer_order_id"
    t.decimal  "duration",          precision: 4, scale: 2
    t.index ["customer_order_id"], name: "index_serving_times_on_customer_order_id", using: :btree
    t.index ["employee_id"], name: "index_serving_times_on_employee_id", using: :btree
  end

  create_table "shifts", force: :cascade do |t|
    t.date     "work_day"
    t.time     "start_at"
    t.time     "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "system_managers", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
    t.index ["email"], name: "index_system_managers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_system_managers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "waiters", force: :cascade do |t|
  end

  add_foreign_key "customer_order_drinks", "customer_orders"
  add_foreign_key "customer_order_drinks", "drinks"
  add_foreign_key "customer_order_foods", "customer_orders"
  add_foreign_key "customer_order_foods", "foods"
  add_foreign_key "customer_order_part_drinks", "customer_order_parts"
  add_foreign_key "customer_order_part_drinks", "drinks"
  add_foreign_key "customer_order_part_foods", "customer_order_parts"
  add_foreign_key "customer_order_part_foods", "foods"
  add_foreign_key "customer_order_parts", "customer_orders"
  add_foreign_key "customer_order_parts", "employees"
  add_foreign_key "customer_order_seats", "customer_orders"
  add_foreign_key "customer_order_seats", "number_of_seats"
  add_foreign_key "customer_orders", "customers"
  add_foreign_key "drink_reviews", "customers"
  add_foreign_key "drink_reviews", "drinks"
  add_foreign_key "drink_reviews", "reviews"
  add_foreign_key "drinks", "restaurants"
  add_foreign_key "employee_reviews", "customers"
  add_foreign_key "employee_reviews", "employees"
  add_foreign_key "employee_reviews", "reviews"
  add_foreign_key "employee_shifts", "employees"
  add_foreign_key "employee_shifts", "seats"
  add_foreign_key "employee_shifts", "shifts"
  add_foreign_key "employees", "managers"
  add_foreign_key "food_reviews", "customers"
  add_foreign_key "food_reviews", "foods"
  add_foreign_key "food_reviews", "reviews"
  add_foreign_key "foods", "restaurants"
  add_foreign_key "number_of_seats", "seats"
  add_foreign_key "offer_items", "offers"
  add_foreign_key "offer_items", "order_items"
  add_foreign_key "offers", "orders"
  add_foreign_key "offers", "providers"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "restaurants"
  add_foreign_key "reservation_invitations", "customers"
  add_foreign_key "reservation_invitations", "reservations"
  add_foreign_key "reservation_orders", "customer_orders"
  add_foreign_key "reservation_orders", "reservations"
  add_foreign_key "reservations", "customers"
  add_foreign_key "reservations", "restaurants"
  add_foreign_key "reserved_tables", "number_of_seats"
  add_foreign_key "reserved_tables", "reservations"
  add_foreign_key "restaurant_locations", "locations"
  add_foreign_key "restaurant_locations", "restaurants"
  add_foreign_key "restaurant_providers", "providers"
  add_foreign_key "restaurant_providers", "restaurants"
  add_foreign_key "restaurant_reviews", "customers"
  add_foreign_key "restaurant_reviews", "restaurants"
  add_foreign_key "restaurant_reviews", "reviews"
  add_foreign_key "restaurants", "managers"
  add_foreign_key "seats", "restaurants"
  add_foreign_key "serving_times", "customer_orders"
  add_foreign_key "serving_times", "employees"
end
