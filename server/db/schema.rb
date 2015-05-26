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

ActiveRecord::Schema.define(version: 20150526035143) do

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

  add_index "articles", ["link"], name: "index_articles_on_link", using: :btree
  add_index "articles", ["positivity_score"], name: "index_articles_on_positivity_score", using: :btree
  add_index "articles", ["source"], name: "index_articles_on_source", using: :btree
  add_index "articles", ["stock_id"], name: "index_articles_on_stock_id", using: :btree
  add_index "articles", ["title"], name: "index_articles_on_title", using: :btree

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

  add_index "reddits", ["date"], name: "index_reddits_on_date", using: :btree
  add_index "reddits", ["link"], name: "index_reddits_on_link", using: :btree
  add_index "reddits", ["positivity_score"], name: "index_reddits_on_positivity_score", using: :btree
  add_index "reddits", ["stock_id"], name: "index_reddits_on_stock_id", using: :btree
  add_index "reddits", ["subreddit_id"], name: "index_reddits_on_subreddit_id", using: :btree
  add_index "reddits", ["title"], name: "index_reddits_on_title", using: :btree

  create_table "stock_prices", force: :cascade do |t|
    t.integer  "stock_id"
    t.string   "open"
    t.string   "days_high"
    t.string   "days_low"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
    t.string   "close"
    t.string   "adj_close"
    t.integer  "volume"
  end

  add_index "stock_prices", ["date"], name: "index_stock_prices_on_date", using: :btree
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
    t.jsonb    "data"
    t.json     "keywords"
    t.float    "positivity_score"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.json     "sentiment"
  end

  add_index "tweets", ["data"], name: "index_tweets_on_data", using: :gin
  add_index "tweets", ["positivity_score"], name: "index_tweets_on_positivity_score", using: :btree
  add_index "tweets", ["stock_id"], name: "index_tweets_on_stock_id", using: :btree

end
