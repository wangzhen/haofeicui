# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101109030533) do

  create_table "administrators", :force => true do |t|
    t.string   "name"
    t.string   "salted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_comments", :force => true do |t|
    t.text     "content"
    t.string   "ipaddr"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "article_id"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "subhead"
    t.string   "from"
    t.string   "author"
    t.string   "summary"
    t.text     "body"
    t.string   "status"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "sort"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "serial"
    t.string   "phone"
    t.string   "name"
    t.string   "email"
    t.string   "qq"
    t.string   "content"
    t.string   "reply"
    t.string   "ipaddr"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forgotten_passwords", :force => true do |t|
    t.integer  "user_id"
    t.string   "reset_code"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_lines", :force => true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.string   "name"
    t.string   "sort"
    t.string   "color"
    t.integer  "quantity"
    t.integer  "price"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "status",                 :default => 1
    t.string   "serial"
    t.integer  "subtotal"
    t.integer  "total"
    t.integer  "adjustment"
    t.integer  "mailing_commition"
    t.integer  "payment"
    t.string   "user_name"
    t.integer  "mailing_id"
    t.date     "delivery_schedule_date"
    t.string   "delivery_serial"
    t.date     "completed_on"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "address"
    t.string   "postal_code"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.string   "user_remark"
    t.string   "admin_remark"
    t.datetime "deleted_at"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "prodcut_questions", :force => true do |t|
    t.string   "comment"
    t.integer  "meddle"
    t.string   "ipaddr"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_comments", :force => true do |t|
    t.string   "content"
    t.integer  "price"
    t.string   "ipaddr"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_contacts", :force => true do |t|
    t.string   "name"
    t.string   "reply"
    t.string   "ipaddr"
    t.integer  "user_id"
    t.integer  "product_id"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_images", :force => true do |t|
    t.integer  "product_id"
    t.integer  "sort"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "serial"
    t.string   "proved_serial"
    t.integer  "sort_id"
    t.integer  "color_id"
    t.integer  "user_id"
    t.integer  "price"
    t.integer  "current_price"
    t.text     "introduction"
    t.integer  "rank"
    t.integer  "hits"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sorts", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                      :limit => 50
    t.string   "email",                     :limit => 50,                 :null => false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.string   "nickname",                  :limit => 50
    t.integer  "rank",                                     :default => 0
    t.string   "introduction"
    t.integer  "point",                                    :default => 0
    t.integer  "coin"
    t.string   "phone",                     :limit => 20
    t.string   "mobile",                    :limit => 20
    t.string   "address",                   :limit => 100
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.integer  "state",                                    :default => 0
    t.string   "image_file_name",           :limit => 50
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
