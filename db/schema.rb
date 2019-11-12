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

ActiveRecord::Schema.define(version: 20190611202618) do

  create_table "attachments", force: :cascade do |t|
    t.string   "filename",     limit: 255
    t.string   "content_type", limit: 255
    t.binary   "data",         limit: 4294967295
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "banner_videos", force: :cascade do |t|
    t.integer  "campaign_id",              limit: 4
    t.datetime "interval_start"
    t.datetime "interval_end"
    t.decimal  "total_basket_value",                        precision: 15, scale: 6
    t.decimal  "total_budget",                              precision: 15, scale: 6
    t.integer  "vast_video_width",         limit: 4
    t.integer  "vast_video_height",        limit: 4
    t.decimal  "bid_ecpm",                                  precision: 15, scale: 6
    t.integer  "vast_video_linerarity",    limit: 4
    t.integer  "vast_video_duration",      limit: 4
    t.text     "vast_video_type",          limit: 65535
    t.text     "vast_video_outgoing_file", limit: 16777215
    t.integer  "bids",                     limit: 4
    t.integer  "clicks",                   limit: 4
    t.integer  "pixels",                   limit: 4
    t.integer  "wins",                     limit: 4
    t.decimal  "total_cost",                                precision: 15, scale: 6, default: 0.0
    t.decimal  "daily_cost",                                precision: 15, scale: 6
    t.decimal  "daily_budget",                              precision: 15, scale: 6
    t.text     "frequency_spec",           limit: 65535
    t.integer  "frequency_expire",         limit: 4
    t.integer  "frequency_count",          limit: 4
    t.string   "frequency_interval_type",  limit: 10,                                              default: 'minutes'
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
    t.decimal  "hourly_budget",                             precision: 15, scale: 6
    t.string   "name",                     limit: 255
    t.integer  "target_id",                limit: 4
    t.decimal  "hourly_cost",                               precision: 15, scale: 6
    t.integer  "bitrate",                  limit: 4
    t.string   "mime_type",                limit: 255
    t.string   "deals",                    limit: 255
    t.string   "width_range",              limit: 255
    t.string   "height_range",             limit: 255
    t.string   "width_height_list",        limit: 255
  end

  create_table "banner_videos_rtb_standards", id: false, force: :cascade do |t|
    t.integer "banner_video_id", limit: 4
    t.integer "rtb_standard_id", limit: 4
  end

  add_index "banner_videos_rtb_standards", ["banner_video_id"], name: "index_banner_videos_rtb_standards_on_banner_video_id", using: :btree
  add_index "banner_videos_rtb_standards", ["rtb_standard_id"], name: "index_banner_videos_rtb_standards_on_rtb_standard_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.integer  "campaign_id",             limit: 4
    t.datetime "interval_start",                                                    null: false
    t.datetime "interval_end"
    t.decimal  "total_basket_value",                       precision: 15, scale: 6
    t.integer  "width",                   limit: 4
    t.integer  "height",                  limit: 4
    t.decimal  "bid_ecpm",                                 precision: 15, scale: 6
    t.decimal  "total_cost",                               precision: 15, scale: 6
    t.string   "contenttype",             limit: 1024
    t.string   "iurl",                    limit: 1024
    t.text     "htmltemplate",            limit: 16777215
    t.integer  "bids",                    limit: 4
    t.integer  "clicks",                  limit: 4
    t.integer  "pixels",                  limit: 4
    t.integer  "wins",                    limit: 4
    t.decimal  "daily_budget",                             precision: 15, scale: 6
    t.decimal  "hourly_budget",                            precision: 15, scale: 6
    t.decimal  "daily_cost",                               precision: 15, scale: 6
    t.integer  "target_id",               limit: 4
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
    t.string   "name",                    limit: 255
    t.string   "frequency_spec",          limit: 255
    t.integer  "frequency_expire",        limit: 4
    t.integer  "frequency_count",         limit: 4
    t.string   "frequency_interval_type", limit: 10,                                              default: 'minutes'
    t.decimal  "hourly_cost",                              precision: 15, scale: 6
    t.string   "deals",                   limit: 255
    t.string   "width_range",             limit: 255
    t.string   "height_range",            limit: 255
    t.string   "width_height_list",       limit: 255
  end

  create_table "banners_rtb_standards", id: false, force: :cascade do |t|
    t.integer "banner_id",       limit: 4
    t.integer "rtb_standard_id", limit: 4
  end

  add_index "banners_rtb_standards", ["banner_id"], name: "index_banners_rtb_standards_on_banner_id", using: :btree
  add_index "banners_rtb_standards", ["rtb_standard_id"], name: "index_banners_rtb_standards_on_rtb_standard_id", using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.datetime "activate_time"
    t.datetime "expire_time"
    t.decimal  "cost",                                  precision: 15, scale: 6
    t.string   "ad_domain",               limit: 1024
    t.integer  "clicks",                  limit: 4
    t.integer  "pixels",                  limit: 4
    t.integer  "wins",                    limit: 4
    t.integer  "bids",                    limit: 4
    t.string   "name",                    limit: 1024
    t.string   "status",                  limit: 1024
    t.string   "conversion_type",         limit: 1024
    t.decimal  "budget_limit_daily",                    precision: 15, scale: 6
    t.decimal  "budget_limit_hourly",                   precision: 15, scale: 6
    t.decimal  "total_budget",                          precision: 15, scale: 6
    t.decimal  "bid",                                   precision: 15, scale: 6
    t.text     "shard",                   limit: 65535
    t.text     "forensiq",                limit: 65535
    t.decimal  "daily_cost",                            precision: 15, scale: 6
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.decimal  "hourly_cost",                           precision: 15, scale: 6
    t.string   "exchanges",               limit: 255
    t.string   "regions",                 limit: 255
    t.integer  "target_id",               limit: 4
    t.string   "frequency_spec",          limit: 255
    t.integer  "frequency_expire",        limit: 4
    t.integer  "frequency_count",         limit: 4
    t.string   "frequency_interval_type", limit: 10,                                              default: 'minutes'
  end

  create_table "campaigns_rtb_standards", id: false, force: :cascade do |t|
    t.integer "campaign_id",     limit: 4
    t.integer "rtb_standard_id", limit: 4
  end

  add_index "campaigns_rtb_standards", ["campaign_id"], name: "index_campaigns_rtb_standards_on_campaign_id", using: :btree
  add_index "campaigns_rtb_standards", ["rtb_standard_id"], name: "index_campaigns_rtb_standards_on_rtb_standard_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 1024
    t.string   "description", limit: 2048
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "categories_documents", id: false, force: :cascade do |t|
    t.integer "document_id", limit: 4
    t.integer "category_id", limit: 4
  end

  add_index "categories_documents", ["category_id"], name: "index_categories_documents_on_category_id", using: :btree
  add_index "categories_documents", ["document_id"], name: "index_categories_documents_on_document_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string "sort_order",               limit: 255
    t.string "common_name",              limit: 255
    t.string "formal_name",              limit: 255
    t.string "country_type",             limit: 255
    t.string "sub_type",                 limit: 255
    t.string "sovereignty",              limit: 255
    t.string "capital",                  limit: 255
    t.string "iso_4217_currency_code",   limit: 255
    t.string "iso_4217_currency_name",   limit: 255
    t.string "iso_3166_1_2_letter_code", limit: 255
    t.string "iso_3166_1_3_letter_code", limit: 255
    t.string "iso_3166_1_number",        limit: 255
    t.string "iana_country_code_tld",    limit: 255
    t.string "itu_t_telephone_code",     limit: 255
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name",        limit: 1024
    t.string   "description", limit: 2048
    t.string   "doctype",     limit: 1024
    t.text     "code",        limit: 65535
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "exchange_attributes", force: :cascade do |t|
    t.integer  "banner_id",       limit: 4
    t.integer  "banner_video_id", limit: 4
    t.string   "name",            limit: 255
    t.string   "value",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "exchange",        limit: 255
  end

  add_index "exchange_attributes", ["banner_id"], name: "index_exchange_attributes_on_banner_id", using: :btree
  add_index "exchange_attributes", ["banner_video_id"], name: "index_exchange_attributes_on_banner_video_id", using: :btree

  create_table "exchange_rtbspecs", force: :cascade do |t|
    t.string   "rtbspecification", limit: 1024
    t.string   "operand_type",     limit: 1024
    t.string   "operand_ordinal",  limit: 1024
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "exchange_smarty_ads_rtbspecs", force: :cascade do |t|
    t.string   "rtbspecification", limit: 1024
    t.string   "operand_type",     limit: 1024
    t.string   "operand_ordinal",  limit: 1024
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  create_table "iab_categories", force: :cascade do |t|
    t.text     "group",      limit: 65535
    t.text     "name",       limit: 65535
    t.text     "iab_id",     limit: 65535
    t.boolean  "is_group"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name",          limit: 1024
    t.string   "description",   limit: 4096
    t.string   "list_type",     limit: 1024
    t.integer  "filesize",      limit: 4
    t.string   "s3_url",        limit: 4096
    t.string   "filepath",      limit: 4096
    t.string   "filetype",      limit: 4096
    t.string   "last_modified", limit: 1024
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "report_commands", force: :cascade do |t|
    t.string   "name",            limit: 1024
    t.string   "type",            limit: 1024
    t.integer  "campaign_id",     limit: 4
    t.string   "description",     limit: 2048
    t.text     "command",         limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "banner_id",       limit: 4
    t.integer  "banner_video_id", limit: 4
  end

  create_table "rtb_standards", force: :cascade do |t|
    t.string   "rtbspecification", limit: 1024
    t.string   "operator",         limit: 1024
    t.string   "operand",          limit: 1024
    t.string   "operand_type",     limit: 16
    t.string   "operand_ordinal",  limit: 16
    t.boolean  "rtb_required"
    t.string   "name",             limit: 255
    t.string   "description",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "operand_list_id",  limit: 4
  end

  create_table "stats_rtb", force: :cascade do |t|
    t.integer  "campaign_id", limit: 4
    t.datetime "stats_date"
    t.integer  "bids",        limit: 4
    t.integer  "wins",        limit: 4
    t.integer  "clicks",      limit: 4
    t.integer  "pixels",      limit: 4
    t.decimal  "win_price",             precision: 15, scale: 6
    t.decimal  "bid_price",             precision: 15, scale: 6
  end

  create_table "targets", force: :cascade do |t|
    t.datetime "activate_time"
    t.datetime "expire_time"
    t.text     "list_of_domains",      limit: 16777215
    t.string   "domain_targetting",    limit: 50
    t.float    "geo_latitude",         limit: 53
    t.float    "geo_longitude",        limit: 53
    t.float    "geo_range",            limit: 53
    t.text     "country",              limit: 65535
    t.text     "geo_region",           limit: 65535
    t.text     "carrier",              limit: 65535
    t.text     "os",                   limit: 65535
    t.text     "make",                 limit: 65535
    t.text     "model",                limit: 65535
    t.text     "devicetype",           limit: 65535
    t.text     "IAB_category",         limit: 65535
    t.text     "IAB_category_blklist", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                 limit: 255
    t.integer  "domains_list_id",      limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.boolean  "admin"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
