# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130314144815) do

  create_table "articles", :force => true do |t|
    t.string   "topic"
    t.text     "content"
    t.integer  "newsletter_id"
    t.integer  "antecessor_id"
    t.boolean  "show_dividerline"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "position"
  end

  add_index "articles", ["antecessor_id"], :name => "index_articles_on_antecessor_id"
  add_index "articles", ["newsletter_id"], :name => "index_articles_on_newsletter_id"

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "phone"
    t.string   "email"
    t.string   "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "newsletters", :force => true do |t|
    t.string   "topic"
    t.text     "content"
    t.integer  "author_id"
    t.integer  "template_id"
    t.integer  "status_id"
    t.boolean  "show_outline"
    t.text     "code"
    t.boolean  "show_dividerline"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "sidearticles", :force => true do |t|
    t.string   "topic"
    t.text     "content"
    t.integer  "newsletter_id"
    t.integer  "position"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "sidearticles", ["newsletter_id"], :name => "index_sidearticles_on_newsletter_id"

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "html"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
