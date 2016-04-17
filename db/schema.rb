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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160417055109) do

  create_table "authors", force: :cascade do |t|
    t.string   "author_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "book_authors", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_authors", ["author_id"], name: "index_book_authors_on_author_id"
  add_index "book_authors", ["book_id"], name: "index_book_authors_on_book_id"

  create_table "book_topics", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "topic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_topics", ["book_id"], name: "index_book_topics_on_book_id"
  add_index "book_topics", ["topic_id"], name: "index_book_topics_on_topic_id"

  create_table "books", force: :cascade do |t|
    t.string   "book_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics", force: :cascade do |t|
    t.string   "topic_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
