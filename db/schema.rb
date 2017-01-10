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

ActiveRecord::Schema.define(version: 20161111021337) do

  create_table "aspects", force: :cascade do |t|
    t.integer  "evaluation_id", precision: 38
    t.string   "subj"
    t.string   "target"
    t.datetime "created_at",    precision: 6,  null: false
    t.datetime "updated_at",    precision: 6,  null: false
  end

  add_index "aspects", ["evaluation_id"], name: "index_aspects_on_evaluation_id"

  create_table "comments", force: :cascade do |t|
    t.string   "text",       limit: 2000
    t.datetime "created_at",              precision: 6,  null: false
    t.datetime "updated_at",              precision: 6,  null: false
    t.integer  "user_id",                 precision: 38
  end

  create_table "enquetes", force: :cascade do |t|
    t.string   "sex",                       null: false
    t.integer  "age",        precision: 38, null: false
    t.string   "place",                     null: false
    t.string   "job",                       null: false
    t.string   "machine",                   null: false
    t.integer  "user_id",    precision: 38, null: false
    t.string   "motivation",                null: false
    t.datetime "created_at", precision: 6,  null: false
    t.datetime "updated_at", precision: 6,  null: false
  end

  add_index "enquetes", ["user_id"], name: "index_enquetes_on_user_id"

  create_table "evaluations", force: :cascade do |t|
    t.integer  "user_id",    precision: 38
    t.integer  "tweet_id",   precision: 38
    t.datetime "created_at", precision: 6,                  null: false
    t.datetime "updated_at", precision: 6,                  null: false
    t.boolean  "neutral",                   default: false
    t.boolean  "positive",                  default: false
    t.boolean  "negative",                  default: false
    t.boolean  "na"
    t.datetime "start_at",   precision: 6,                  null: false
    t.datetime "end_at",     precision: 6,                  null: false
    t.integer  "elapsed",    precision: 38,                 null: false
  end

  add_index "evaluations", ["elapsed"], name: "index_evaluations_on_elapsed"
  add_index "evaluations", ["end_at"], name: "index_evaluations_on_end_at"
  add_index "evaluations", ["negative"], name: "index_evaluations_on_negative"
  add_index "evaluations", ["neutral"], name: "index_evaluations_on_neutral"
  add_index "evaluations", ["positive"], name: "index_evaluations_on_positive"
  add_index "evaluations", ["start_at"], name: "index_evaluations_on_start_at"
  add_index "evaluations", ["tweet_id"], name: "index_evaluations_on_tweet_id"
  add_index "evaluations", ["user_id", "tweet_id"], name: "i_evaluations_user_id_tweet_id", unique: true
  add_index "evaluations", ["user_id"], name: "index_evaluations_on_user_id"

  create_table "genres", force: :cascade do |t|
    t.string   "genre_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "point_rates", force: :cascade do |t|
    t.integer  "user_id",    precision: 38,                 null: false
    t.float    "rating",                                    null: false
    t.datetime "created_at", precision: 6,                  null: false
    t.datetime "updated_at", precision: 6,                  null: false
    t.boolean  "read_flag",                 default: false
  end

  add_index "point_rates", ["user_id"], name: "index_point_rates_on_user_id"

  create_table "points", force: :cascade do |t|
    t.integer  "user_id",       precision: 38
    t.integer  "tweet_id",      precision: 38
    t.datetime "created_at",    precision: 6,                null: false
    t.datetime "updated_at",    precision: 6,                null: false
    t.integer  "evaluation_id", precision: 38
    t.float    "rate",                         default: 1.0, null: false
  end

  add_index "points", ["user_id", "tweet_id"], name: "i_points_user_id_tweet_id", unique: true

  create_table "red_cards", force: :cascade do |t|
    t.integer  "from_user_id", precision: 38,                 null: false
    t.integer  "to_user_id",   precision: 38,                 null: false
    t.integer  "evaluation",   precision: 38,                 null: false
    t.string   "comment",                                     null: false
    t.boolean  "read_flag",                   default: false
    t.datetime "created_at",   precision: 6,                  null: false
    t.datetime "updated_at",   precision: 6,                  null: false
  end

  add_index "red_cards", ["from_user_id", "to_user_id"], name: "i_red_car_fro_use_id_to_use_id", unique: true
  add_index "red_cards", ["from_user_id"], name: "i_red_cards_from_user_id"
  add_index "red_cards", ["to_user_id"], name: "index_red_cards_on_to_user_id"

  create_table "task_queues", force: :cascade do |t|
    t.integer  "tweet_id",   precision: 38
    t.integer  "user_id",    precision: 38
    t.datetime "created_at", precision: 6,  null: false
    t.datetime "updated_at", precision: 6,  null: false
  end

  create_table "tweet_users", force: :cascade do |t|
    t.integer  "user_id",     precision: 38
    t.string   "user_name"
    t.datetime "created_at",  precision: 6,  null: false
    t.datetime "updated_at",  precision: 6,  null: false
    t.string   "screen_name"
  end

  add_index "tweet_users", ["user_id"], name: "index_tweet_users_on_user_id", unique: true
  add_index "tweet_users", ["user_name"], name: "index_tweet_users_on_user_name"

  create_table "tweets", force: :cascade do |t|
    t.datetime "created_at",                    precision: 6,                  null: false
    t.datetime "updated_at",                    precision: 6,                  null: false
    t.datetime "tweet_date",                    precision: 6
    t.integer  "genre_id",                      precision: 38
    t.integer  "tweet_user_id",                 precision: 38
    t.string   "source"
    t.integer  "tweet_id",                      precision: 38
    t.string   "tweet",            limit: 2000
    t.integer  "evaluation_count",              precision: 38, default: 0
    t.integer  "pn_count",                      precision: 38, default: 0
    t.integer  "p_count",                       precision: 38, default: 0
    t.integer  "n_count",                       precision: 38, default: 0
    t.integer  "ne_count",                      precision: 38, default: 0
    t.integer  "na_count",                      precision: 38, default: 0
    t.integer  "decision",                      precision: 38, default: -1
    t.boolean  "pn_flag",                                      default: false
    t.boolean  "p_flag",                                       default: false
    t.boolean  "n_flag",                                       default: false
    t.boolean  "ne_flag",                                      default: false
    t.boolean  "na_flag",                                      default: false
  end

  add_index "tweets", ["decision"], name: "index_tweets_on_decision"
  add_index "tweets", ["genre_id"], name: "index_tweets_on_genre_id"
  add_index "tweets", ["n_count"], name: "index_tweets_on_n_count"
  add_index "tweets", ["n_flag"], name: "index_tweets_on_n_flag"
  add_index "tweets", ["na_count"], name: "index_tweets_on_na_count"
  add_index "tweets", ["na_flag"], name: "index_tweets_on_na_flag"
  add_index "tweets", ["ne_count"], name: "index_tweets_on_ne_count"
  add_index "tweets", ["ne_flag"], name: "index_tweets_on_ne_flag"
  add_index "tweets", ["p_count"], name: "index_tweets_on_p_count"
  add_index "tweets", ["p_flag"], name: "index_tweets_on_p_flag"
  add_index "tweets", ["pn_count"], name: "index_tweets_on_pn_count"
  add_index "tweets", ["pn_flag"], name: "index_tweets_on_pn_flag"
  add_index "tweets", ["tweet_id"], name: "index_tweets_on_tweet_id"
  add_index "tweets", ["tweet_user_id"], name: "index_tweets_on_tweet_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                                 default: "",    null: false
    t.string   "username",                              default: "",    null: false
    t.string   "encrypted_password",                    default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at",    precision: 6
    t.integer  "sign_in_count",          precision: 38, default: 0,     null: false
    t.datetime "current_sign_in_at",     precision: 6
    t.datetime "last_sign_in_at",        precision: 6
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at",           precision: 6
    t.datetime "confirmation_sent_at",   precision: 6
    t.string   "unconfirmed_email"
    t.datetime "created_at",             precision: 6,                  null: false
    t.datetime "updated_at",             precision: 6,                  null: false
    t.boolean  "admin",                                 default: false, null: false
    t.integer  "points_count",           precision: 38, default: 0
    t.integer  "evaluations_count",      precision: 38, default: 0
    t.string   "memo"
    t.boolean  "practice",                              default: false
    t.integer  "team",                   precision: 38, default: 0
    t.boolean  "locked",                                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "i_users_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "zero_evaluate_tweets", force: :cascade do |t|
    t.integer  "tweet_id",   precision: 38, null: false
    t.datetime "created_at", precision: 6,  null: false
    t.datetime "updated_at", precision: 6,  null: false
  end

