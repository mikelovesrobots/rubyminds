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

ActiveRecord::Schema.define(:version => 20090304170930) do

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body",       :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_cache", :limit => 16777215
    t.integer  "parent_id"
  end

  add_index "posts", ["parent_id", "created_at"], :name => "index_posts_on_parent_id_and_created_at"

  add_foreign_key "posts", ["parent_id"], "posts", ["id"], :name => "posts_ibfk_1"

end
