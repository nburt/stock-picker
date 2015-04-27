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

ActiveRecord::Schema.define(version: 20150427003442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.integer  "stock_id"
    t.string   "title"
    t.text     "description"
    t.string   "link"
    t.datetime "date"
    t.json     "keywords"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "positivity_score"
    t.json     "sentiment"
    t.json     "data"
    t.string   "source"
    t.json     "section"
  end

  add_index "articles", ["stock_id"], name: "index_articles_on_stock_id", using: :btree

  create_table "reddits", force: :cascade do |t|
    t.integer  "stock_id"
    t.string   "title"
    t.string   "link"
    t.datetime "date"
    t.json     "data"
    t.string   "subreddit_id"
    t.json     "keywords"
    t.float    "positivity_score"
    t.json     "sentiment"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "reddits", ["stock_id"], name: "index_reddits_on_stock_id", using: :btree

  create_table "stock_prices", force: :cascade do |t|
    t.integer  "stock_id"
    t.string   "open"
    t.string   "previous_close"
    t.string   "year_high"
    t.string   "year_low"
    t.string   "days_high"
    t.string   "days_low"
    t.string   "bid_realtime"
    t.string   "market_cap"
    t.string   "last_trade_price"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "stock_prices", ["stock_id"], name: "index_stock_prices_on_stock_id", using: :btree

  create_table "stocks", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "ticker_symbol",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "twitter_handle"
  end

  create_table "tweets", force: :cascade do |t|
    t.integer  "stock_id"
    t.json     "data"
    t.json     "keywords"
    t.float    "positivity_score"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.json     "sentiment"
  end

  add_index "tweets", ["stock_id"], name: "index_tweets_on_stock_id", using: :btree

end
