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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120428161915) do

  create_table "jobs", :force => true do |t|
    t.integer  "s_year"
    t.integer  "s_month"
    t.integer  "s_day"
    t.integer  "e_year"
    t.integer  "e_month"
    t.integer  "e_day"
    t.integer  "current_job"
    t.string   "city"
    t.string   "country"
    t.string   "state_us"
    t.string   "institution"
    t.string   "department"
    t.string   "position"
    t.string   "job_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "s_date"
    t.datetime "e_date"
    t.text     "content"
  end

  add_index "jobs", ["user_id"], :name => "index_jobs_on_user_id_and_e_date"
  add_index "jobs", ["user_id"], :name => "index_jobs_on_user_id_and_s_date"

  create_table "posts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "degree1"
    t.integer  "year"
    t.text     "likes"
    t.string   "linkedin"
    t.boolean  "admin",              :default => false
    t.string   "degree2"
    t.string   "blog"
    t.integer  "age"
    t.string   "telephone"
    t.string   "procedence"
    t.string   "current_location"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
