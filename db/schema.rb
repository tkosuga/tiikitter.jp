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

ActiveRecord::Schema.define(:version => 20100713152607) do

  create_table "bots", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.string   "password",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "secret"
  end

  create_table "locations", :force => true do |t|
    t.string   "name",       :limit => 64,                :null => false
    t.float    "lat",                                     :null => false
    t.float    "lng",                                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "x",                        :default => 0, :null => false
    t.integer  "y",                        :default => 0, :null => false
  end

  add_index "locations", ["lat"], :name => "index_locations_on_lat"
  add_index "locations", ["lng"], :name => "index_locations_on_lng"
  add_index "locations", ["name"], :name => "index_locations_on_name", :unique => true
  add_index "locations", ["x"], :name => "index_locations_on_x"
  add_index "locations", ["y"], :name => "index_locations_on_y"

  create_table "sentences", :force => true do |t|
    t.string   "text",                     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id", :limit => 8
  end

  add_index "sentences", ["location_id"], :name => "index_sentences_on_location_id", :unique => true
  add_index "sentences", ["text"], :name => "index_sentences_on_text", :unique => true

  create_table "timeline_diagnoses", :force => true do |t|
    t.integer  "sentence_id", :limit => 8, :null => false
    t.integer  "timeline_id", :limit => 8, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeline_diagnoses", ["sentence_id"], :name => "index_timeline_diagnoses_on_sentence_id"
  add_index "timeline_diagnoses", ["timeline_id"], :name => "index_timeline_diagnoses_on_timeline_id"

  create_table "timelines", :force => true do |t|
    t.integer  "time_line_id",          :limit => 8, :null => false
    t.datetime "time_line_created_at",               :null => false
    t.integer  "in_reply_to_status_id", :limit => 8
    t.string   "text",                               :null => false
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile_image_uri"
    t.string   "user_name"
    t.string   "user_screen_name"
  end

  add_index "timelines", ["in_reply_to_status_id"], :name => "index_timelines_on_in_reply_to_status_id"
  add_index "timelines", ["profile_image_uri"], :name => "index_timelines_on_profile_image_uri"
  add_index "timelines", ["source"], :name => "index_timelines_on_source"
  add_index "timelines", ["text"], :name => "index_timelines_on_text"
  add_index "timelines", ["time_line_created_at"], :name => "index_timelines_on_time_line_created_at"
  add_index "timelines", ["time_line_id"], :name => "index_timelines_on_time_line_id", :unique => true
  add_index "timelines", ["user_name"], :name => "index_timelines_on_user_name"
  add_index "timelines", ["user_screen_name"], :name => "index_timelines_on_user_screen_name"

end
