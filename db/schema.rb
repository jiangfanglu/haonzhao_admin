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

ActiveRecord::Schema.define(version: 20140318092448) do

  create_table "addresses", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artworks", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attribute_descriptions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attribute_group_descriptions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attribute_groups", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attributes", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "available_categories", force: true do |t|
    t.integer "category_id"
    t.integer "sort_order"
  end

  create_table "available_custom_providers", force: true do |t|
    t.integer "user_id"
    t.integer "category_id"
  end

  create_table "balances", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_descriptions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_options", force: true do |t|
    t.integer "category_id"
    t.integer "option_id"
  end

  create_table "category_to_attributes", force: true do |t|
    t.integer  "category_id"
    t.integer  "attribute_group_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "category_to_groups", force: true do |t|
    t.integer  "category_id"
    t.integer  "group_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "cities", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: true do |t|
    t.integer  "user_id"
    t.integer  "collectable_id"
    t.string   "collectable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "comments", force: true do |t|
    t.string   "content"
    t.string   "ip"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "likescount"
    t.integer  "parent_comment_id"
  end

  create_table "countries", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_order_requests", force: true do |t|
    t.integer  "manufacturer_id"
    t.integer  "order_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "sample"
  end

  create_table "custom_orders", force: true do |t|
    t.integer  "cutomer_user_id"
    t.integer  "order_taker_id"
    t.integer  "status"
    t.integer  "category_id"
    t.text     "option_value_params"
    t.text     "images_params"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "keywords"
    t.integer  "request_count"
    t.integer  "timelimit"
  end

  create_table "customers", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "exhibitions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fees", force: true do |t|
    t.string   "fee_type"
    t.string   "rate"
    t.integer  "service_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "followers", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hat_area", primary_key: "rid", force: true do |t|
    t.string "areaID", limit: 50
    t.string "area",   limit: 60
    t.string "father", limit: 6
  end

  create_table "hat_city", primary_key: "cid", force: true do |t|
    t.string "cityID", limit: 6
    t.string "city",   limit: 50
    t.string "father", limit: 6
  end

  create_table "hat_province", primary_key: "sid", force: true do |t|
    t.string "provinceID", limit: 6
    t.string "province",   limit: 40
  end

  create_table "images", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: true do |t|
    t.string   "ip"
    t.integer  "user_id"
    t.integer  "likable_id"
    t.string   "likable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "lists", force: true do |t|
    t.string   "ip"
    t.integer  "list_id",    null: false
    t.integer  "product_id", null: false
    t.integer  "artwork_id", null: false
    t.integer  "author_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "maillists", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oc_address", primary_key: "address_id", force: true do |t|
    t.integer "customer_id",                           null: false
    t.string  "firstname",   limit: 32,  default: "",  null: false
    t.string  "lastname",    limit: 32,  default: "",  null: false
    t.string  "company",     limit: 32,                null: false
    t.string  "company_id",  limit: 32,                null: false
    t.string  "tax_id",      limit: 32,                null: false
    t.string  "address_1",   limit: 128,               null: false
    t.string  "address_2",   limit: 128,               null: false
    t.string  "city",        limit: 10,                null: false
    t.string  "postcode",    limit: 10,                null: false
    t.integer "country_id",              default: 0,   null: false
    t.string  "zone_id",     limit: 10,  default: "0", null: false
    t.string  "province",    limit: 10,                null: false
    t.string  "district_id", limit: 10,                null: false
  end

  add_index "oc_address", ["customer_id"], name: "customer_id", using: :btree

  create_table "oc_affiliate", primary_key: "affiliate_id", force: true do |t|
    t.string   "firstname",           limit: 32,                          default: "",  null: false
    t.string   "lastname",            limit: 32,                          default: "",  null: false
    t.string   "email",               limit: 96,                          default: "",  null: false
    t.string   "telephone",           limit: 32,                          default: "",  null: false
    t.string   "fax",                 limit: 32,                          default: "",  null: false
    t.string   "password",            limit: 40,                          default: "",  null: false
    t.string   "salt",                limit: 9,                           default: "",  null: false
    t.string   "company",             limit: 32,                                        null: false
    t.string   "website",                                                               null: false
    t.string   "address_1",           limit: 128,                         default: "",  null: false
    t.string   "address_2",           limit: 128,                                       null: false
    t.string   "city",                limit: 128,                         default: "",  null: false
    t.string   "postcode",            limit: 10,                          default: "",  null: false
    t.integer  "country_id",                                                            null: false
    t.integer  "zone_id",                                                               null: false
    t.string   "code",                limit: 64,                                        null: false
    t.decimal  "commission",                      precision: 4, scale: 2, default: 0.0, null: false
    t.string   "tax",                 limit: 64,                                        null: false
    t.string   "payment",             limit: 6,                                         null: false
    t.string   "cheque",              limit: 100,                         default: "",  null: false
    t.string   "paypal",              limit: 64,                          default: "",  null: false
    t.string   "bank_name",           limit: 64,                          default: "",  null: false
    t.string   "bank_branch_number",  limit: 64,                          default: "",  null: false
    t.string   "bank_swift_code",     limit: 64,                          default: "",  null: false
    t.string   "bank_account_name",   limit: 64,                          default: "",  null: false
    t.string   "bank_account_number", limit: 64,                          default: "",  null: false
    t.string   "ip",                  limit: 40,                                        null: false
    t.boolean  "status",                                                                null: false
    t.boolean  "approved",                                                              null: false
    t.datetime "date_added",                                                            null: false
  end

  create_table "oc_affiliate_transaction", primary_key: "affiliate_transaction_id", force: true do |t|
    t.integer  "affiliate_id",                          null: false
    t.integer  "order_id",                              null: false
    t.text     "description",                           null: false
    t.decimal  "amount",       precision: 15, scale: 4, null: false
    t.datetime "date_added",                            null: false
  end

  create_table "oc_attribute", primary_key: "attribute_id", force: true do |t|
    t.integer "attribute_group_id", null: false
    t.integer "sort_order",         null: false
  end

  create_table "oc_attribute_description", id: false, force: true do |t|
    t.integer "attribute_id",            null: false
    t.integer "language_id",             null: false
    t.string  "name",         limit: 64, null: false
  end

  create_table "oc_attribute_group", primary_key: "attribute_group_id", force: true do |t|
    t.integer "sort_order", null: false
  end

  create_table "oc_attribute_group_description", id: false, force: true do |t|
    t.integer "attribute_group_id",            null: false
    t.integer "language_id",                   null: false
    t.string  "name",               limit: 64, null: false
  end

  create_table "oc_banner", primary_key: "banner_id", force: true do |t|
    t.string  "name",   limit: 64, null: false
    t.boolean "status",            null: false
  end

  create_table "oc_banner_image", primary_key: "banner_image_id", force: true do |t|
    t.integer "banner_id", null: false
    t.string  "link",      null: false
    t.string  "image",     null: false
  end

  create_table "oc_banner_image_description", id: false, force: true do |t|
    t.integer "banner_image_id",            null: false
    t.integer "language_id",                null: false
    t.integer "banner_id",                  null: false
    t.string  "title",           limit: 64, null: false
  end

  create_table "oc_category", primary_key: "category_id", force: true do |t|
    t.string   "image"
    t.integer  "parent_id",     default: 0, null: false
    t.boolean  "top",                       null: false
    t.integer  "column",                    null: false
    t.integer  "sort_order",    default: 0, null: false
    t.boolean  "status",                    null: false
    t.datetime "date_added",                null: false
    t.datetime "date_modified",             null: false
  end

  create_table "oc_category_description", id: false, force: true do |t|
    t.integer "category_id",                   null: false
    t.integer "language_id",                   null: false
    t.string  "name",             default: "", null: false
    t.text    "description",                   null: false
    t.string  "meta_description",              null: false
    t.string  "meta_keyword",                  null: false
  end

  add_index "oc_category_description", ["name"], name: "name", using: :btree

  create_table "oc_category_to_layout", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "store_id",    null: false
    t.integer "layout_id",   null: false
  end

  create_table "oc_category_to_store", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "store_id",    null: false
  end

  create_table "oc_country", primary_key: "country_id", force: true do |t|
    t.string  "name",              limit: 128,                null: false
    t.string  "iso_code_2",        limit: 2,   default: "",   null: false
    t.string  "iso_code_3",        limit: 3,   default: "",   null: false
    t.text    "address_format",                               null: false
    t.boolean "postcode_required",                            null: false
    t.boolean "status",                        default: true, null: false
  end

  create_table "oc_coupon", primary_key: "coupon_id", force: true do |t|
    t.string   "name",          limit: 128,                          null: false
    t.string   "code",          limit: 10,                           null: false
    t.string   "type",          limit: 1,                            null: false
    t.decimal  "discount",                  precision: 15, scale: 4, null: false
    t.boolean  "logged",                                             null: false
    t.boolean  "shipping",                                           null: false
    t.decimal  "total",                     precision: 15, scale: 4, null: false
    t.date     "date_start",                                         null: false
    t.date     "date_end",                                           null: false
    t.integer  "uses_total",                                         null: false
    t.string   "uses_customer", limit: 11,                           null: false
    t.boolean  "status",                                             null: false
    t.datetime "date_added",                                         null: false
  end

  create_table "oc_coupon_history", primary_key: "coupon_history_id", force: true do |t|
    t.integer  "coupon_id",                            null: false
    t.integer  "order_id",                             null: false
    t.integer  "customer_id",                          null: false
    t.decimal  "amount",      precision: 15, scale: 4, null: false
    t.datetime "date_added",                           null: false
  end

  create_table "oc_coupon_product", primary_key: "coupon_product_id", force: true do |t|
    t.integer "coupon_id",  null: false
    t.integer "product_id", null: false
  end

  create_table "oc_currency", primary_key: "currency_id", force: true do |t|
    t.string   "title",         limit: 32, default: "", null: false
    t.string   "code",          limit: 3,  default: "", null: false
    t.string   "symbol_left",   limit: 12,              null: false
    t.string   "symbol_right",  limit: 12,              null: false
    t.string   "decimal_place", limit: 1,               null: false
    t.float    "value",         limit: 15,              null: false
    t.boolean  "status",                                null: false
    t.datetime "date_modified",                         null: false
  end

  create_table "oc_customer", primary_key: "customer_id", force: true do |t|
    t.integer   "store_id",                      default: 0,                     null: false
    t.string    "firstname",         limit: 32,  default: "",                    null: false
    t.string    "lastname",          limit: 32,  default: "",                    null: false
    t.string    "email",             limit: 96,  default: "",                    null: false
    t.string    "telephone",         limit: 32,  default: "",                    null: false
    t.string    "fax",               limit: 32,  default: "",                    null: false
    t.string    "password",          limit: 100, default: "",                    null: false
    t.string    "salt",              limit: 12,  default: "",                    null: false
    t.text      "cart"
    t.text      "wishlist"
    t.boolean   "newsletter",                    default: false,                 null: false
    t.integer   "address_id",                    default: 0,                     null: false
    t.integer   "customer_group_id",                                             null: false
    t.string    "ip",                limit: 40,  default: "0",                   null: false
    t.boolean   "status",                                                        null: false
    t.boolean   "approved",                                                      null: false
    t.string    "token",                                                         null: false
    t.timestamp "date_added",                    default: '2014-01-01 12:12:12', null: false
    t.integer   "user_id"
    t.string    "payment"
  end

  create_table "oc_customer_group", primary_key: "customer_group_id", force: true do |t|
    t.integer "approval",            null: false
    t.integer "company_id_display",  null: false
    t.integer "company_id_required", null: false
    t.integer "tax_id_display",      null: false
    t.integer "tax_id_required",     null: false
    t.integer "sort_order",          null: false
  end

  create_table "oc_customer_group_description", id: false, force: true do |t|
    t.integer "customer_group_id",            null: false
    t.integer "language_id",                  null: false
    t.string  "name",              limit: 32, null: false
    t.text    "description",                  null: false
  end

  create_table "oc_customer_ip", primary_key: "customer_ip_id", force: true do |t|
    t.integer  "customer_id",            null: false
    t.string   "ip",          limit: 40, null: false
    t.datetime "date_added",             null: false
  end

  add_index "oc_customer_ip", ["ip"], name: "ip", using: :btree

  create_table "oc_customer_ip_blacklist", primary_key: "customer_ip_blacklist_id", force: true do |t|
    t.string "ip", limit: 40, null: false
  end

  add_index "oc_customer_ip_blacklist", ["ip"], name: "ip", using: :btree

  create_table "oc_customer_online", primary_key: "ip", force: true do |t|
    t.integer  "customer_id", null: false
    t.text     "url",         null: false
    t.text     "referer",     null: false
    t.datetime "date_added",  null: false
  end

  create_table "oc_customer_reward", primary_key: "customer_reward_id", force: true do |t|
    t.integer  "customer_id", default: 0, null: false
    t.integer  "order_id",    default: 0, null: false
    t.text     "description",             null: false
    t.integer  "points",      default: 0, null: false
    t.datetime "date_added",              null: false
  end

  create_table "oc_customer_transaction", primary_key: "customer_transaction_id", force: true do |t|
    t.integer  "customer_id",                          null: false
    t.integer  "order_id",                             null: false
    t.text     "description",                          null: false
    t.decimal  "amount",      precision: 15, scale: 4, null: false
    t.datetime "date_added",                           null: false
  end

  create_table "oc_download", primary_key: "download_id", force: true do |t|
    t.string   "filename",   limit: 128, default: "", null: false
    t.string   "mask",       limit: 128, default: "", null: false
    t.integer  "remaining",              default: 0,  null: false
    t.datetime "date_added",                          null: false
  end

  create_table "oc_download_description", id: false, force: true do |t|
    t.integer "download_id",                         null: false
    t.integer "language_id",                         null: false
    t.string  "name",        limit: 64, default: "", null: false
  end

  create_table "oc_extension", primary_key: "extension_id", force: true do |t|
    t.string "type", limit: 32, null: false
    t.string "code", limit: 32, null: false
  end

  create_table "oc_geo_zone", primary_key: "geo_zone_id", force: true do |t|
    t.string   "name",          limit: 32, default: "", null: false
    t.string   "description",              default: "", null: false
    t.datetime "date_modified",                         null: false
    t.datetime "date_added",                            null: false
  end

  create_table "oc_information", primary_key: "information_id", force: true do |t|
    t.integer "bottom",     default: 0,    null: false
    t.integer "sort_order", default: 0,    null: false
    t.boolean "status",     default: true, null: false
  end

  create_table "oc_information_description", id: false, force: true do |t|
    t.integer "information_id",                         null: false
    t.integer "language_id",                            null: false
    t.string  "title",          limit: 64, default: "", null: false
    t.text    "description",                            null: false
  end

  create_table "oc_information_to_layout", id: false, force: true do |t|
    t.integer "information_id", null: false
    t.integer "store_id",       null: false
    t.integer "layout_id",      null: false
  end

  create_table "oc_information_to_store", id: false, force: true do |t|
    t.integer "information_id", null: false
    t.integer "store_id",       null: false
  end

  create_table "oc_language", primary_key: "language_id", force: true do |t|
    t.string  "name",       limit: 32, default: "", null: false
    t.string  "code",       limit: 5,               null: false
    t.string  "locale",                             null: false
    t.string  "image",      limit: 64,              null: false
    t.string  "directory",  limit: 32, default: "", null: false
    t.string  "filename",   limit: 64, default: "", null: false
    t.integer "sort_order",            default: 0,  null: false
    t.boolean "status",                             null: false
  end

  add_index "oc_language", ["name"], name: "name", using: :btree

  create_table "oc_layout", primary_key: "layout_id", force: true do |t|
    t.string "name", limit: 64, null: false
  end

  create_table "oc_layout_route", primary_key: "layout_route_id", force: true do |t|
    t.integer "layout_id", null: false
    t.integer "store_id",  null: false
    t.string  "route",     null: false
  end

  create_table "oc_length_class", primary_key: "length_class_id", force: true do |t|
    t.decimal "value", precision: 15, scale: 8, null: false
  end

  create_table "oc_length_class_description", id: false, force: true do |t|
    t.integer "length_class_id",            null: false
    t.integer "language_id",                null: false
    t.string  "title",           limit: 32, null: false
    t.string  "unit",            limit: 4,  null: false
  end

  create_table "oc_manufacturer", primary_key: "manufacturer_id", force: true do |t|
    t.string  "name",               limit: 64, default: "", null: false
    t.string  "image"
    t.integer "sort_order",                                 null: false
    t.string  "identity_no"
    t.string  "business_rego_no"
    t.string  "business_name"
    t.string  "organization_no"
    t.string  "register_type"
    t.integer "shipping_option_id"
    t.string  "status"
  end

  create_table "oc_manufacturer_to_store", id: false, force: true do |t|
    t.integer "manufacturer_id", null: false
    t.integer "store_id",        null: false
  end

  create_table "oc_option", primary_key: "option_id", force: true do |t|
    t.string  "option_type", limit: 32, null: false
    t.integer "sort_order",             null: false
  end

  create_table "oc_option_description", id: false, force: true do |t|
    t.integer "option_id",               null: false
    t.integer "language_id",             null: false
    t.string  "name",        limit: 128, null: false
  end

  create_table "oc_option_value", primary_key: "option_value_id", force: true do |t|
    t.integer "option_id",  null: false
    t.string  "image",      null: false
    t.integer "sort_order", null: false
  end

  create_table "oc_option_value_description", id: false, force: true do |t|
    t.integer "option_value_id",                                                  null: false
    t.integer "language_id",                                                      null: false
    t.integer "option_id",                                                        null: false
    t.string  "name",            limit: 128,                                      null: false
    t.decimal "price",                       precision: 10, scale: 0, default: 0, null: false
  end

  create_table "oc_order", primary_key: "order_id", force: true do |t|
    t.integer  "invoice_no",                                                   default: 0,   null: false
    t.string   "invoice_prefix",          limit: 26,                                         null: false
    t.integer  "store_id",                                                     default: 0,   null: false
    t.string   "store_name",              limit: 64,                                         null: false
    t.string   "store_url",                                                                  null: false
    t.integer  "customer_id",                                                  default: 0,   null: false
    t.integer  "customer_group_id",                                            default: 0,   null: false
    t.string   "firstname",               limit: 32,                           default: "",  null: false
    t.string   "lastname",                limit: 32,                                         null: false
    t.string   "email",                   limit: 96,                                         null: false
    t.string   "telephone",               limit: 32,                           default: "",  null: false
    t.string   "fax",                     limit: 32,                           default: "",  null: false
    t.string   "payment_firstname",       limit: 32,                           default: "",  null: false
    t.string   "payment_lastname",        limit: 32,                           default: "",  null: false
    t.string   "payment_company",         limit: 32,                                         null: false
    t.string   "payment_company_id",      limit: 32,                                         null: false
    t.string   "payment_tax_id",          limit: 32,                                         null: false
    t.string   "payment_address_1",       limit: 128,                                        null: false
    t.string   "payment_address_2",       limit: 128,                                        null: false
    t.string   "payment_city",            limit: 128,                                        null: false
    t.string   "payment_postcode",        limit: 10,                           default: "",  null: false
    t.string   "payment_country",         limit: 128,                                        null: false
    t.integer  "payment_country_id",                                                         null: false
    t.string   "payment_zone",            limit: 128,                                        null: false
    t.integer  "payment_zone_id",                                                            null: false
    t.text     "payment_address_format",                                                     null: false
    t.string   "payment_method",          limit: 128,                          default: "",  null: false
    t.string   "payment_code",            limit: 128,                                        null: false
    t.string   "shipping_firstname",      limit: 32,                                         null: false
    t.string   "shipping_lastname",       limit: 32,                           default: "",  null: false
    t.string   "shipping_company",        limit: 32,                                         null: false
    t.string   "shipping_address_1",      limit: 128,                                        null: false
    t.string   "shipping_address_2",      limit: 128,                                        null: false
    t.string   "shipping_city",           limit: 128,                                        null: false
    t.string   "shipping_postcode",       limit: 10,                           default: "",  null: false
    t.string   "shipping_country",        limit: 128,                                        null: false
    t.integer  "shipping_country_id",                                                        null: false
    t.string   "shipping_zone",           limit: 128,                                        null: false
    t.integer  "shipping_zone_id",                                                           null: false
    t.text     "shipping_address_format",                                                    null: false
    t.string   "shipping_method",         limit: 128,                          default: "",  null: false
    t.string   "shipping_code",           limit: 128,                                        null: false
    t.text     "comment",                                                                    null: false
    t.decimal  "total",                               precision: 15, scale: 4, default: 0.0, null: false
    t.integer  "order_status_id",                                              default: 0,   null: false
    t.integer  "affiliate_id",                                                               null: false
    t.decimal  "commission",                          precision: 15, scale: 4,               null: false
    t.integer  "language_id",                                                                null: false
    t.integer  "currency_id",                                                                null: false
    t.string   "currency_code",           limit: 3,                                          null: false
    t.decimal  "currency_value",                      precision: 15, scale: 8, default: 1.0, null: false
    t.string   "ip",                      limit: 40,                                         null: false
    t.string   "forwarded_ip",            limit: 40,                                         null: false
    t.string   "user_agent",                                                                 null: false
    t.string   "accept_language",                                                            null: false
    t.datetime "date_added",                                                                 null: false
    t.datetime "date_modified",                                                              null: false
    t.integer  "shipping_option_id"
    t.integer  "address_id"
    t.string   "order_sn"
    t.string   "payment_sn"
  end

  create_table "oc_order_download", primary_key: "order_download_id", force: true do |t|
    t.integer "order_id",                                  null: false
    t.integer "order_product_id",                          null: false
    t.string  "name",             limit: 64,  default: "", null: false
    t.string  "filename",         limit: 128, default: "", null: false
    t.string  "mask",             limit: 128, default: "", null: false
    t.integer "remaining",                    default: 0,  null: false
  end

  create_table "oc_order_fraud", primary_key: "order_id", force: true do |t|
    t.integer  "customer_id",                                                            null: false
    t.string   "country_match",                      limit: 3,                           null: false
    t.string   "country_code",                       limit: 2,                           null: false
    t.string   "high_risk_country",                  limit: 3,                           null: false
    t.integer  "distance",                                                               null: false
    t.string   "ip_region",                                                              null: false
    t.string   "ip_city",                                                                null: false
    t.decimal  "ip_latitude",                                   precision: 10, scale: 6, null: false
    t.decimal  "ip_longitude",                                  precision: 10, scale: 6, null: false
    t.string   "ip_isp",                                                                 null: false
    t.string   "ip_org",                                                                 null: false
    t.integer  "ip_asnum",                                                               null: false
    t.string   "ip_user_type",                                                           null: false
    t.string   "ip_country_confidence",              limit: 3,                           null: false
    t.string   "ip_region_confidence",               limit: 3,                           null: false
    t.string   "ip_city_confidence",                 limit: 3,                           null: false
    t.string   "ip_postal_confidence",               limit: 3,                           null: false
    t.string   "ip_postal_code",                     limit: 10,                          null: false
    t.integer  "ip_accuracy_radius",                                                     null: false
    t.string   "ip_net_speed_cell",                                                      null: false
    t.integer  "ip_metro_code",                                                          null: false
    t.integer  "ip_area_code",                                                           null: false
    t.string   "ip_time_zone",                                                           null: false
    t.string   "ip_region_name",                                                         null: false
    t.string   "ip_domain",                                                              null: false
    t.string   "ip_country_name",                                                        null: false
    t.string   "ip_continent_code",                  limit: 2,                           null: false
    t.string   "ip_corporate_proxy",                 limit: 3,                           null: false
    t.string   "anonymous_proxy",                    limit: 3,                           null: false
    t.integer  "proxy_score",                                                            null: false
    t.string   "is_trans_proxy",                     limit: 3,                           null: false
    t.string   "free_mail",                          limit: 3,                           null: false
    t.string   "carder_email",                       limit: 3,                           null: false
    t.string   "high_risk_username",                 limit: 3,                           null: false
    t.string   "high_risk_password",                 limit: 3,                           null: false
    t.string   "bin_match",                          limit: 10,                          null: false
    t.string   "bin_country",                        limit: 2,                           null: false
    t.string   "bin_name_match",                     limit: 3,                           null: false
    t.string   "bin_name",                                                               null: false
    t.string   "bin_phone_match",                    limit: 3,                           null: false
    t.string   "bin_phone",                          limit: 32,                          null: false
    t.string   "customer_phone_in_billing_location", limit: 8,                           null: false
    t.string   "ship_forward",                       limit: 3,                           null: false
    t.string   "city_postal_match",                  limit: 3,                           null: false
    t.string   "ship_city_postal_match",             limit: 3,                           null: false
    t.decimal  "score",                                         precision: 10, scale: 5, null: false
    t.text     "explanation",                                                            null: false
    t.decimal  "risk_score",                                    precision: 10, scale: 5, null: false
    t.integer  "queries_remaining",                                                      null: false
    t.string   "maxmind_id",                         limit: 8,                           null: false
    t.text     "error",                                                                  null: false
    t.datetime "date_added",                                                             null: false
  end

  create_table "oc_order_history", primary_key: "order_history_id", force: true do |t|
    t.integer   "order_id",                                        null: false
    t.integer   "order_status_id",                                 null: false
    t.boolean   "notify",          default: false,                 null: false
    t.text      "comment",                                         null: false
    t.timestamp "date_added",      default: '2014-01-01 00:00:01', null: false
    t.integer   "operation_id"
    t.string    "operator_role"
    t.integer   "operator_id"
  end

  create_table "oc_order_option", primary_key: "order_option_id", force: true do |t|
    t.integer "order_id",                                       null: false
    t.integer "order_product_id",                               null: false
    t.integer "product_option_id",                              null: false
    t.integer "product_option_value_id",            default: 0, null: false
    t.string  "name",                                           null: false
    t.text    "value",                                          null: false
    t.string  "option_type",             limit: 32,             null: false
  end

  create_table "oc_order_product", primary_key: "order_product_id", force: true do |t|
    t.integer "order_id",                                                     null: false
    t.integer "product_id",                                                   null: false
    t.string  "name",                                                         null: false
    t.string  "model",      limit: 64,                                        null: false
    t.integer "quantity",                                                     null: false
    t.decimal "price",                 precision: 15, scale: 4, default: 0.0, null: false
    t.decimal "total",                 precision: 15, scale: 4, default: 0.0, null: false
    t.decimal "tax",                   precision: 15, scale: 4, default: 0.0, null: false
    t.integer "reward",                                                       null: false
  end

  create_table "oc_order_status", id: false, force: true do |t|
    t.integer "order_status_id",            null: false
    t.integer "language_id",                null: false
    t.string  "name",            limit: 32, null: false
  end

  create_table "oc_order_total", primary_key: "order_total_id", force: true do |t|
    t.integer "order_id",                                                     null: false
    t.string  "code",       limit: 32,                                        null: false
    t.string  "title",                                          default: "",  null: false
    t.string  "text",                                           default: "",  null: false
    t.decimal "value",                 precision: 15, scale: 4, default: 0.0, null: false
    t.integer "sort_order",                                                   null: false
  end

  add_index "oc_order_total", ["order_id"], name: "idx_orders_total_orders_id", using: :btree

  create_table "oc_order_voucher", primary_key: "order_voucher_id", force: true do |t|
    t.integer "order_id",                                             null: false
    t.integer "voucher_id",                                           null: false
    t.string  "description",                                          null: false
    t.string  "code",             limit: 10,                          null: false
    t.string  "from_name",        limit: 64,                          null: false
    t.string  "from_email",       limit: 96,                          null: false
    t.string  "to_name",          limit: 64,                          null: false
    t.string  "to_email",         limit: 96,                          null: false
    t.integer "voucher_theme_id",                                     null: false
    t.text    "message",                                              null: false
    t.decimal "amount",                      precision: 15, scale: 4, null: false
  end

  create_table "oc_product", primary_key: "product_id", force: true do |t|
    t.string   "model",           limit: 64,                                           null: false
    t.string   "sku",             limit: 64,                                           null: false
    t.string   "upc",             limit: 12,                                           null: false
    t.string   "ean",             limit: 14,                                           null: false
    t.string   "jan",             limit: 13,                                           null: false
    t.string   "isbn",            limit: 13,                                           null: false
    t.string   "mpn",             limit: 64,                                           null: false
    t.string   "location",        limit: 128,                                          null: false
    t.integer  "quantity",                                             default: 0,     null: false
    t.integer  "stock_status_id",                                                      null: false
    t.string   "image"
    t.integer  "manufacturer_id",                                                      null: false
    t.boolean  "shipping",                                             default: true,  null: false
    t.decimal  "price",                       precision: 15, scale: 4, default: 0.0,   null: false
    t.integer  "points",                                               default: 0,     null: false
    t.integer  "tax_class_id",                                                         null: false
    t.date     "date_available",                                                       null: false
    t.decimal  "weight",                      precision: 15, scale: 8, default: 0.0,   null: false
    t.integer  "weight_class_id",                                      default: 0,     null: false
    t.decimal  "length",                      precision: 15, scale: 8, default: 0.0,   null: false
    t.decimal  "width",                       precision: 15, scale: 8, default: 0.0,   null: false
    t.decimal  "height",                      precision: 15, scale: 8, default: 0.0,   null: false
    t.integer  "length_class_id",                                      default: 0,     null: false
    t.boolean  "subtract",                                             default: true,  null: false
    t.integer  "minimum",                                              default: 1,     null: false
    t.integer  "sort_order",                                           default: 0,     null: false
    t.boolean  "status",                                               default: false, null: false
    t.datetime "date_added",                                                           null: false
    t.datetime "date_modified",                                                        null: false
    t.integer  "viewed",                                               default: 0,     null: false
  end

  create_table "oc_product_attribute", id: false, force: true do |t|
    t.integer "product_id",   null: false
    t.integer "attribute_id", null: false
    t.integer "language_id",  null: false
    t.text    "text",         null: false
  end

  create_table "oc_product_description", id: false, force: true do |t|
    t.integer "product_id",       null: false
    t.integer "language_id",      null: false
    t.string  "name",             null: false
    t.text    "description",      null: false
    t.string  "meta_description", null: false
    t.string  "meta_keyword",     null: false
    t.text    "tag",              null: false
  end

  add_index "oc_product_description", ["description"], name: "description", type: :fulltext
  add_index "oc_product_description", ["name"], name: "name", using: :btree
  add_index "oc_product_description", ["tag"], name: "tag", type: :fulltext

  create_table "oc_product_discount", primary_key: "product_discount_id", force: true do |t|
    t.integer "product_id",                                               null: false
    t.integer "customer_group_id",                                        null: false
    t.integer "quantity",                                   default: 0,   null: false
    t.integer "priority",                                   default: 1,   null: false
    t.decimal "price",             precision: 15, scale: 4, default: 0.0, null: false
    t.date    "date_start",                                               null: false
    t.date    "date_end",                                                 null: false
  end

  add_index "oc_product_discount", ["product_id"], name: "product_id", using: :btree

  create_table "oc_product_image", primary_key: "product_image_id", force: true do |t|
    t.integer "product_id",             null: false
    t.string  "image"
    t.integer "sort_order", default: 0, null: false
  end

  create_table "oc_product_option", primary_key: "product_option_id", force: true do |t|
    t.integer "product_id",   null: false
    t.integer "option_id",    null: false
    t.text    "option_value", null: false
    t.boolean "required",     null: false
  end

  create_table "oc_product_option_value", primary_key: "product_option_value_id", force: true do |t|
    t.integer "product_option_id",                                    null: false
    t.integer "product_id",                                           null: false
    t.integer "option_id",                                            null: false
    t.integer "option_value_id",                                      null: false
    t.integer "quantity",                                             null: false
    t.boolean "subtract",                                             null: false
    t.decimal "price",                       precision: 15, scale: 4, null: false
    t.string  "price_prefix",      limit: 1,                          null: false
    t.integer "points",                                               null: false
    t.string  "points_prefix",     limit: 1,                          null: false
    t.decimal "weight",                      precision: 15, scale: 8, null: false
    t.string  "weight_prefix",     limit: 1,                          null: false
  end

  create_table "oc_product_related", id: false, force: true do |t|
    t.integer "product_id", null: false
    t.integer "related_id", null: false
  end

  create_table "oc_product_reward", primary_key: "product_reward_id", force: true do |t|
    t.integer "product_id",        default: 0, null: false
    t.integer "customer_group_id", default: 0, null: false
    t.integer "points",            default: 0, null: false
  end

  create_table "oc_product_special", primary_key: "product_special_id", force: true do |t|
    t.integer "product_id",                                               null: false
    t.integer "customer_group_id",                                        null: false
    t.integer "priority",                                   default: 1,   null: false
    t.decimal "price",             precision: 15, scale: 4, default: 0.0, null: false
    t.date    "date_start",                                               null: false
    t.date    "date_end",                                                 null: false
  end

  add_index "oc_product_special", ["product_id"], name: "product_id", using: :btree

  create_table "oc_product_to_category", id: false, force: true do |t|
    t.integer "product_id",  null: false
    t.integer "category_id", null: false
  end

  create_table "oc_product_to_download", id: false, force: true do |t|
    t.integer "product_id",  null: false
    t.integer "download_id", null: false
  end

  create_table "oc_product_to_layout", id: false, force: true do |t|
    t.integer "product_id", null: false
    t.integer "store_id",   null: false
    t.integer "layout_id",  null: false
  end

  create_table "oc_product_to_store", id: false, force: true do |t|
    t.integer "product_id",             null: false
    t.integer "store_id",   default: 0, null: false
  end

  create_table "oc_return", primary_key: "return_id", force: true do |t|
    t.integer  "order_id",                    null: false
    t.integer  "product_id",                  null: false
    t.integer  "customer_id",                 null: false
    t.string   "firstname",        limit: 32, null: false
    t.string   "lastname",         limit: 32, null: false
    t.string   "email",            limit: 96, null: false
    t.string   "telephone",        limit: 32, null: false
    t.string   "product",                     null: false
    t.string   "model",            limit: 64, null: false
    t.integer  "quantity",                    null: false
    t.boolean  "opened",                      null: false
    t.integer  "return_reason_id",            null: false
    t.integer  "return_action_id",            null: false
    t.integer  "return_status_id",            null: false
    t.text     "comment"
    t.date     "date_ordered",                null: false
    t.datetime "date_added",                  null: false
    t.datetime "date_modified",               null: false
  end

  create_table "oc_return_action", id: false, force: true do |t|
    t.integer "return_action_id",                         null: false
    t.integer "language_id",                 default: 0,  null: false
    t.string  "name",             limit: 64, default: "", null: false
  end

  create_table "oc_return_history", primary_key: "return_history_id", force: true do |t|
    t.integer  "return_id",        null: false
    t.integer  "return_status_id", null: false
    t.boolean  "notify",           null: false
    t.text     "comment",          null: false
    t.datetime "date_added",       null: false
  end

  create_table "oc_return_reason", id: false, force: true do |t|
    t.integer "return_reason_id",                          null: false
    t.integer "language_id",                  default: 0,  null: false
    t.string  "name",             limit: 128, default: "", null: false
  end

  create_table "oc_return_status", id: false, force: true do |t|
    t.integer "return_status_id",                         null: false
    t.integer "language_id",                 default: 0,  null: false
    t.string  "name",             limit: 32, default: "", null: false
  end

  create_table "oc_review", primary_key: "review_id", force: true do |t|
    t.integer   "product_id",                                                  null: false
    t.integer   "customer_id",                                                 null: false
    t.string    "author",           limit: 64, default: "",                    null: false
    t.text      "text",                                                        null: false
    t.integer   "rating",                                                      null: false
    t.boolean   "status",                      default: false,                 null: false
    t.timestamp "date_added",                  default: '2014-01-01 12:12:12', null: false
    t.timestamp "date_modified",               default: '2014-01-01 12:12:12', null: false
    t.integer   "order_product_id"
  end

  add_index "oc_review", ["product_id"], name: "product_id", using: :btree

  create_table "oc_setting", primary_key: "setting_id", force: true do |t|
    t.integer "store_id",              default: 0,  null: false
    t.string  "group",      limit: 32,              null: false
    t.string  "key",        limit: 64, default: "", null: false
    t.text    "value",                              null: false
    t.boolean "serialized",                         null: false
  end

  create_table "oc_shipping", primary_key: "shipping_id", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oc_shipping_option", primary_key: "shipping_option_id", force: true do |t|
    t.string   "option_value"
    t.integer  "shipping_id"
    t.integer  "price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "oc_stock_status", id: false, force: true do |t|
    t.integer "stock_status_id",            null: false
    t.integer "language_id",                null: false
    t.string  "name",            limit: 32, null: false
  end

  create_table "oc_store", primary_key: "store_id", force: true do |t|
    t.string "name", limit: 64, null: false
    t.string "url",             null: false
    t.string "ssl",             null: false
  end

  create_table "oc_tax_class", primary_key: "tax_class_id", force: true do |t|
    t.string   "title",         limit: 32, default: "", null: false
    t.string   "description",              default: "", null: false
    t.datetime "date_added",                            null: false
    t.datetime "date_modified",                         null: false
  end

  create_table "oc_tax_rate", primary_key: "tax_rate_id", force: true do |t|
    t.integer  "geo_zone_id",                                       default: 0,   null: false
    t.string   "name",          limit: 32,                                        null: false
    t.decimal  "rate",                     precision: 15, scale: 4, default: 0.0, null: false
    t.string   "type",          limit: 1,                                         null: false
    t.datetime "date_added",                                                      null: false
    t.datetime "date_modified",                                                   null: false
  end

  create_table "oc_tax_rate_to_customer_group", id: false, force: true do |t|
    t.integer "tax_rate_id",       null: false
    t.integer "customer_group_id", null: false
  end

  create_table "oc_tax_rule", primary_key: "tax_rule_id", force: true do |t|
    t.integer "tax_class_id",                        null: false
    t.integer "tax_rate_id",                         null: false
    t.string  "based",        limit: 10,             null: false
    t.integer "priority",                default: 1, null: false
  end

  create_table "oc_url_alias", primary_key: "url_alias_id", force: true do |t|
    t.string "query",   null: false
    t.string "keyword", null: false
  end

  create_table "oc_user", primary_key: "user_id", force: true do |t|
    t.integer  "user_group_id",                         null: false
    t.string   "username",      limit: 20, default: "", null: false
    t.string   "password",      limit: 40, default: "", null: false
    t.string   "salt",          limit: 9,  default: "", null: false
    t.string   "firstname",     limit: 32, default: "", null: false
    t.string   "lastname",      limit: 32, default: "", null: false
    t.string   "email",         limit: 96, default: "", null: false
    t.string   "code",          limit: 32,              null: false
    t.string   "ip",            limit: 40, default: "", null: false
    t.boolean  "status",                                null: false
    t.datetime "date_added",                            null: false
  end

  create_table "oc_user_group", primary_key: "user_group_id", force: true do |t|
    t.string "name",       limit: 64, null: false
    t.text   "permission",            null: false
  end

  create_table "oc_voucher", primary_key: "voucher_id", force: true do |t|
    t.integer  "order_id",                                             null: false
    t.string   "code",             limit: 10,                          null: false
    t.string   "from_name",        limit: 64,                          null: false
    t.string   "from_email",       limit: 96,                          null: false
    t.string   "to_name",          limit: 64,                          null: false
    t.string   "to_email",         limit: 96,                          null: false
    t.integer  "voucher_theme_id",                                     null: false
    t.text     "message",                                              null: false
    t.decimal  "amount",                      precision: 15, scale: 4, null: false
    t.boolean  "status",                                               null: false
    t.datetime "date_added",                                           null: false
  end

  create_table "oc_voucher_history", primary_key: "voucher_history_id", force: true do |t|
    t.integer  "voucher_id",                          null: false
    t.integer  "order_id",                            null: false
    t.decimal  "amount",     precision: 15, scale: 4, null: false
    t.datetime "date_added",                          null: false
  end

  create_table "oc_voucher_theme", primary_key: "voucher_theme_id", force: true do |t|
    t.string "image", null: false
  end

  create_table "oc_voucher_theme_description", id: false, force: true do |t|
    t.integer "voucher_theme_id",            null: false
    t.integer "language_id",                 null: false
    t.string  "name",             limit: 32, null: false
  end

  create_table "oc_weight_class", primary_key: "weight_class_id", force: true do |t|
    t.decimal "value", precision: 15, scale: 8, default: 0.0, null: false
  end

  create_table "oc_weight_class_description", id: false, force: true do |t|
    t.integer "weight_class_id",                         null: false
    t.integer "language_id",                             null: false
    t.string  "title",           limit: 32,              null: false
    t.string  "unit",            limit: 4,  default: "", null: false
  end

  create_table "oc_zone", primary_key: "zone_id", force: true do |t|
    t.integer "country_id",                            null: false
    t.string  "name",       limit: 128,                null: false
    t.string  "code",       limit: 32,  default: "",   null: false
    t.boolean "status",                 default: true, null: false
  end

  create_table "oc_zone_to_geo_zone", primary_key: "zone_to_geo_zone_id", force: true do |t|
    t.integer  "country_id",                null: false
    t.integer  "zone_id",       default: 0, null: false
    t.integer  "geo_zone_id",               null: false
    t.datetime "date_added",                null: false
    t.datetime "date_modified",             null: false
  end

  create_table "operations", force: true do |t|
    t.integer  "order_status_id"
    t.string   "name"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "block"
  end

  create_table "option_values", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_histories", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_options", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_products", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_statuses", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_totals", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "password_resets", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_histories", force: true do |t|
    t.integer  "payer_id"
    t.string   "payer_role"
    t.string   "payment_name"
    t.string   "payment_interface"
    t.string   "order_sn"
    t.float    "total"
    t.string   "money_sign"
    t.text     "params"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "status"
    t.string   "payment_sn"
  end

  create_table "posts", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_attributes", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_descriptions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_images", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_locations", force: true do |t|
    t.integer  "product_id"
    t.string   "state_id"
    t.string   "city_id"
    t.string   "suburb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_option_values", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_options", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "propertytypes", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publisheds", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: true do |t|
    t.integer  "user_id"
    t.string   "ip"
    t.text     "comment"
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "reviews", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seller_payments", force: true do |t|
    t.integer  "user_id"
    t.string   "payment_type"
    t.string   "payment_account"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "bank_name"
    t.string   "account_name"
    t.string   "fee_type",        default: "basic"
  end

  create_table "service_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: true do |t|
    t.string   "name"
    t.integer  "service_category_id"
    t.integer  "fee_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "shipping_option_and_shops", force: true do |t|
    t.integer  "shipping_option_id"
    t.integer  "shop_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "shop_categories", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "shop_options", force: true do |t|
    t.integer "user_id"
    t.integer "option_id"
  end

  create_table "shops", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_statuses", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suburbs", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: true do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.integer  "taggable_id"
    t.string   "taggable_type"
  end

  create_table "ticket_categories", force: true do |t|
    t.string  "name"
    t.integer "sort_order"
  end

  create_table "ticket_statuses", force: true do |t|
    t.string  "name"
    t.integer "sort_order"
  end

  create_table "tickets", force: true do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "ticket_category_id"
    t.integer  "assigned_user_id"
    t.integer  "ticket_status_id"
    t.string   "email"
    t.string   "user_name"
    t.string   "sn"
  end

  create_table "transactions", force: true do |t|
    t.string   "transaction_source_type"
    t.integer  "transaction_source_id"
    t.string   "account_type"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "store_id"
    t.string   "comment"
    t.string   "sn"
    t.float    "money"
    t.string   "money_sign"
    t.string   "status"
  end

  create_table "uploads", force: true do |t|
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "user_groups", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_uploads", force: true do |t|
    t.integer  "user_id"
    t.integer  "filesize"
    t.string   "filename"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userlists", force: true do |t|
    t.integer "user_id"
    t.string  "list_name"
    t.integer "item_count", default: 0
  end

  create_table "userpreferences", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "thumbnail"
  end

  create_table "weblogs", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "ip"
    t.text     "params"
    t.integer  "status"
    t.integer  "likescount"
  end

  create_table "wishlists", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "z2act_artist", force: true do |t|
    t.integer "user_id",                 null: false
    t.string  "portfolio",   limit: 400
    t.string  "website_url", limit: 100
  end

  create_table "z2act_artist_follower", force: true do |t|
    t.integer "artist_user_id",   null: false
    t.integer "follower_user_id", null: false
  end

  create_table "z2act_artist_payment", force: true do |t|
    t.integer   "user_id",                                                          null: false
    t.integer   "payment_type",                                                     null: false
    t.string    "receipt_no",     limit: 15,                                        null: false
    t.timestamp "payment_date",                                                     null: false
    t.decimal   "payment_amount",            precision: 15, scale: 2, default: 0.0, null: false
  end

  create_table "z2act_artwork", force: true do |t|
    t.integer "user_id",                 null: false
    t.integer "category_id",             null: false
    t.string  "title",       limit: 100, null: false
    t.string  "description", limit: 300, null: false
    t.string  "filename",    limit: 100, null: false
    t.string  "meta_desc",   limit: 200, null: false
    t.integer "width",                   null: false
    t.integer "height",                  null: false
    t.integer "filesize",                null: false
    t.integer "status",                  null: false
  end

  create_table "z2act_artwork_actions", force: true do |t|
    t.integer "artwork_id",              null: false
    t.string  "msg",         limit: 200, null: false
    t.integer "read_status",             null: false
    t.integer "actions",                 null: false
  end

  create_table "z2act_artwork_featured", force: true do |t|
    t.integer "artwork_image_id", null: false
    t.integer "order",            null: false
    t.integer "category_id",      null: false
    t.integer "product_id"
  end

  create_table "z2act_artwork_images", force: true do |t|
    t.integer "artwork_id",             null: false
    t.string  "filename",   limit: 100, null: false
    t.integer "width",                  null: false
    t.integer "height",                 null: false
    t.integer "filesize",               null: false
    t.integer "hero",                   null: false
    t.integer "user_id",                null: false
  end

  create_table "z2act_artwork_info", force: true do |t|
    t.integer  "user_id",                             null: false
    t.integer  "category_id",                         null: false
    t.string   "title",       limit: 100,             null: false
    t.string   "description", limit: 300,             null: false
    t.string   "meta_desc",   limit: 200,             null: false
    t.integer  "status",                              null: false
    t.datetime "created",                             null: false
    t.integer  "private",     limit: 1,   default: 0, null: false
    t.integer  "likes"
  end

  create_table "z2act_artwork_publish", force: true do |t|
    t.integer "artwork_id",       null: false
    t.integer "artwork_image_id", null: false
    t.integer "product_id",       null: false
    t.integer "status",           null: false
    t.integer "user_id",          null: false
  end

  create_table "z2act_assets", force: true do |t|
    t.integer "parent_id",              default: 0, null: false
    t.integer "lft",                    default: 0, null: false
    t.integer "rgt",                    default: 0, null: false
    t.integer "level",                              null: false
    t.string  "name",      limit: 50,               null: false
    t.string  "title",     limit: 100,              null: false
    t.string  "rules",     limit: 5120,             null: false
  end

  add_index "z2act_assets", ["lft", "rgt"], name: "idx_lft_rgt", using: :btree
  add_index "z2act_assets", ["name"], name: "idx_asset_name", unique: true, using: :btree
  add_index "z2act_assets", ["parent_id"], name: "idx_parent_id", using: :btree

  create_table "z2act_associations", id: false, force: true do |t|
    t.string "id",      limit: 50, null: false
    t.string "context", limit: 50, null: false
    t.string "key",     limit: 32, null: false
  end

  add_index "z2act_associations", ["key"], name: "idx_key", using: :btree

  create_table "z2act_banner_clients", force: true do |t|
    t.string   "name",                        default: "", null: false
    t.string   "contact",                     default: "", null: false
    t.string   "email",                       default: "", null: false
    t.text     "extrainfo",                                null: false
    t.integer  "state",             limit: 1, default: 0,  null: false
    t.integer  "checked_out",                 default: 0,  null: false
    t.datetime "checked_out_time",                         null: false
    t.text     "metakey",                                  null: false
    t.integer  "own_prefix",        limit: 1, default: 0,  null: false
    t.string   "metakey_prefix",              default: "", null: false
    t.integer  "purchase_type",     limit: 1, default: -1, null: false
    t.integer  "track_clicks",      limit: 1, default: -1, null: false
    t.integer  "track_impressions", limit: 1, default: -1, null: false
  end

  add_index "z2act_banner_clients", ["metakey_prefix"], name: "idx_metakey_prefix", using: :btree
  add_index "z2act_banner_clients", ["own_prefix"], name: "idx_own_prefix", using: :btree

  create_table "z2act_banner_tracks", id: false, force: true do |t|
    t.datetime "track_date",             null: false
    t.integer  "track_type",             null: false
    t.integer  "banner_id",              null: false
    t.integer  "count",      default: 0, null: false
  end

  add_index "z2act_banner_tracks", ["banner_id"], name: "idx_banner_id", using: :btree
  add_index "z2act_banner_tracks", ["track_date"], name: "idx_track_date", using: :btree
  add_index "z2act_banner_tracks", ["track_type"], name: "idx_track_type", using: :btree

  create_table "z2act_banners", force: true do |t|
    t.integer  "cid",                            default: 0,     null: false
    t.integer  "type",                           default: 0,     null: false
    t.string   "name",                           default: "",    null: false
    t.string   "alias",                          default: "",    null: false
    t.integer  "imptotal",                       default: 0,     null: false
    t.integer  "impmade",                        default: 0,     null: false
    t.integer  "clicks",                         default: 0,     null: false
    t.string   "clickurl",          limit: 200,  default: "",    null: false
    t.integer  "state",             limit: 1,    default: 0,     null: false
    t.integer  "catid",                          default: 0,     null: false
    t.text     "description",                                    null: false
    t.string   "custombannercode",  limit: 2048,                 null: false
    t.boolean  "sticky",                         default: false, null: false
    t.integer  "ordering",                       default: 0,     null: false
    t.text     "metakey",                                        null: false
    t.text     "params",                                         null: false
    t.boolean  "own_prefix",                     default: false, null: false
    t.string   "metakey_prefix",                 default: "",    null: false
    t.integer  "purchase_type",     limit: 1,    default: -1,    null: false
    t.integer  "track_clicks",      limit: 1,    default: -1,    null: false
    t.integer  "track_impressions", limit: 1,    default: -1,    null: false
    t.integer  "checked_out",                    default: 0,     null: false
    t.datetime "checked_out_time",                               null: false
    t.datetime "publish_up",                                     null: false
    t.datetime "publish_down",                                   null: false
    t.datetime "reset",                                          null: false
    t.datetime "created",                                        null: false
    t.string   "language",          limit: 7,    default: "",    null: false
    t.integer  "created_by",                     default: 0,     null: false
    t.string   "created_by_alias",               default: "",    null: false
    t.datetime "modified",                                       null: false
    t.integer  "modified_by",                    default: 0,     null: false
    t.integer  "version",                        default: 1,     null: false
  end

  add_index "z2act_banners", ["catid"], name: "idx_banner_catid", using: :btree
  add_index "z2act_banners", ["language"], name: "idx_language", using: :btree
  add_index "z2act_banners", ["metakey_prefix"], name: "idx_metakey_prefix", using: :btree
  add_index "z2act_banners", ["own_prefix"], name: "idx_own_prefix", using: :btree
  add_index "z2act_banners", ["state"], name: "idx_state", using: :btree

  create_table "z2act_categories", force: true do |t|
    t.integer  "asset_id",                          default: 0,     null: false
    t.integer  "parent_id",                         default: 0,     null: false
    t.integer  "lft",                               default: 0,     null: false
    t.integer  "rgt",                               default: 0,     null: false
    t.integer  "level",                             default: 0,     null: false
    t.string   "path",                              default: "",    null: false
    t.string   "extension",        limit: 50,       default: "",    null: false
    t.string   "title",                                             null: false
    t.string   "alias",                             default: "",    null: false
    t.string   "note",                              default: "",    null: false
    t.text     "description",      limit: 16777215,                 null: false
    t.boolean  "published",                         default: false, null: false
    t.integer  "checked_out",                       default: 0,     null: false
    t.datetime "checked_out_time",                                  null: false
    t.integer  "access",                            default: 0,     null: false
    t.text     "params",                                            null: false
    t.string   "metadesc",         limit: 1024,                     null: false
    t.string   "metakey",          limit: 1024,                     null: false
    t.string   "metadata",         limit: 2048,                     null: false
    t.integer  "created_user_id",                   default: 0,     null: false
    t.datetime "created_time",                                      null: false
    t.integer  "modified_user_id",                  default: 0,     null: false
    t.datetime "modified_time",                                     null: false
    t.integer  "hits",                              default: 0,     null: false
    t.string   "language",         limit: 7,                        null: false
    t.integer  "version",                           default: 1,     null: false
  end

  add_index "z2act_categories", ["access"], name: "idx_access", using: :btree
  add_index "z2act_categories", ["alias"], name: "idx_alias", using: :btree
  add_index "z2act_categories", ["checked_out"], name: "idx_checkout", using: :btree
  add_index "z2act_categories", ["extension", "published", "access"], name: "cat_idx", using: :btree
  add_index "z2act_categories", ["language"], name: "idx_language", using: :btree
  add_index "z2act_categories", ["lft", "rgt"], name: "idx_left_right", using: :btree
  add_index "z2act_categories", ["path"], name: "idx_path", using: :btree

  create_table "z2act_comments", primary_key: "comment_id", force: true do |t|
    t.integer  "post_id",                    default: 0,   null: false
    t.string   "image_url",                  default: "",  null: false
    t.string   "video_url",                  default: "",  null: false
    t.integer  "user_id",                    default: 0,   null: false
    t.text     "comment_content",                          null: false
    t.datetime "comment_date",                             null: false
    t.string   "ip",              limit: 40, default: "0", null: false
  end

  add_index "z2act_comments", ["user_id"], name: "user_id", using: :btree

  create_table "z2act_contact_details", force: true do |t|
    t.string   "name",                              default: "",    null: false
    t.string   "alias",                             default: "",    null: false
    t.string   "con_position"
    t.text     "address"
    t.string   "suburb",           limit: 100
    t.string   "state",            limit: 100
    t.string   "country",          limit: 100
    t.string   "postcode",         limit: 100
    t.string   "telephone"
    t.string   "fax"
    t.text     "misc",             limit: 16777215
    t.string   "image"
    t.string   "email_to"
    t.boolean  "default_con",                       default: false, null: false
    t.boolean  "published",                         default: false, null: false
    t.integer  "checked_out",                       default: 0,     null: false
    t.datetime "checked_out_time",                                  null: false
    t.integer  "ordering",                          default: 0,     null: false
    t.text     "params",                                            null: false
    t.integer  "user_id",                           default: 0,     null: false
    t.integer  "catid",                             default: 0,     null: false
    t.integer  "access",                            default: 0,     null: false
    t.string   "mobile",                            default: "",    null: false
    t.string   "webpage",                           default: "",    null: false
    t.string   "sortname1",                                         null: false
    t.string   "sortname2",                                         null: false
    t.string   "sortname3",                                         null: false
    t.string   "language",         limit: 7,                        null: false
    t.datetime "created",                                           null: false
    t.integer  "created_by",                        default: 0,     null: false
    t.string   "created_by_alias",                  default: "",    null: false
    t.datetime "modified",                                          null: false
    t.integer  "modified_by",                       default: 0,     null: false
    t.text     "metakey",                                           null: false
    t.text     "metadesc",                                          null: false
    t.text     "metadata",                                          null: false
    t.integer  "featured",         limit: 1,        default: 0,     null: false
    t.string   "xreference",       limit: 50,                       null: false
    t.datetime "publish_up",                                        null: false
    t.datetime "publish_down",                                      null: false
    t.integer  "version",                           default: 1,     null: false
    t.integer  "hits",                              default: 0,     null: false
  end

  add_index "z2act_contact_details", ["access"], name: "idx_access", using: :btree
  add_index "z2act_contact_details", ["catid"], name: "idx_catid", using: :btree
  add_index "z2act_contact_details", ["checked_out"], name: "idx_checkout", using: :btree
  add_index "z2act_contact_details", ["created_by"], name: "idx_createdby", using: :btree
  add_index "z2act_contact_details", ["featured", "catid"], name: "idx_featured_catid", using: :btree
  add_index "z2act_contact_details", ["language"], name: "idx_language", using: :btree
  add_index "z2act_contact_details", ["published"], name: "idx_state", using: :btree
  add_index "z2act_contact_details", ["xreference"], name: "idx_xreference", using: :btree

  create_table "z2act_content", force: true do |t|
    t.integer  "asset_id",                          default: 0,  null: false
    t.string   "title",                             default: "", null: false
    t.string   "alias",                             default: "", null: false
    t.text     "introtext",        limit: 16777215,              null: false
    t.text     "fulltext",         limit: 16777215,              null: false
    t.integer  "state",            limit: 1,        default: 0,  null: false
    t.integer  "catid",                             default: 0,  null: false
    t.datetime "created",                                        null: false
    t.integer  "created_by",                        default: 0,  null: false
    t.string   "created_by_alias",                  default: "", null: false
    t.datetime "modified",                                       null: false
    t.integer  "modified_by",                       default: 0,  null: false
    t.integer  "checked_out",                       default: 0,  null: false
    t.datetime "checked_out_time",                               null: false
    t.datetime "publish_up",                                     null: false
    t.datetime "publish_down",                                   null: false
    t.text     "images",                                         null: false
    t.text     "urls",                                           null: false
    t.string   "attribs",          limit: 5120,                  null: false
    t.integer  "version",                           default: 1,  null: false
    t.integer  "ordering",                          default: 0,  null: false
    t.text     "metakey",                                        null: false
    t.text     "metadesc",                                       null: false
    t.integer  "access",                            default: 0,  null: false
    t.integer  "hits",                              default: 0,  null: false
    t.text     "metadata",                                       null: false
    t.integer  "featured",         limit: 1,        default: 0,  null: false
    t.string   "language",         limit: 7,                     null: false
    t.string   "xreference",       limit: 50,                    null: false
  end

  add_index "z2act_content", ["access"], name: "idx_access", using: :btree
  add_index "z2act_content", ["catid"], name: "idx_catid", using: :btree
  add_index "z2act_content", ["checked_out"], name: "idx_checkout", using: :btree
  add_index "z2act_content", ["created_by"], name: "idx_createdby", using: :btree
  add_index "z2act_content", ["featured", "catid"], name: "idx_featured_catid", using: :btree
  add_index "z2act_content", ["language"], name: "idx_language", using: :btree
  add_index "z2act_content", ["state"], name: "idx_state", using: :btree
  add_index "z2act_content", ["xreference"], name: "idx_xreference", using: :btree

  create_table "z2act_content_frontpage", primary_key: "content_id", force: true do |t|
    t.integer "ordering", default: 0, null: false
  end

  create_table "z2act_content_rating", primary_key: "content_id", force: true do |t|
    t.integer "rating_sum",              default: 0,  null: false
    t.integer "rating_count",            default: 0,  null: false
    t.string  "lastip",       limit: 50, default: "", null: false
  end

  create_table "z2act_core_log_searches", id: false, force: true do |t|
    t.string  "search_term", limit: 128, default: "", null: false
    t.integer "hits",                    default: 0,  null: false
  end

  create_table "z2act_extensions", primary_key: "extension_id", force: true do |t|
    t.string   "name",             limit: 100,             null: false
    t.string   "type",             limit: 20,              null: false
    t.string   "element",          limit: 100,             null: false
    t.string   "folder",           limit: 100,             null: false
    t.integer  "client_id",        limit: 1,               null: false
    t.integer  "enabled",          limit: 1,   default: 1, null: false
    t.integer  "access",                       default: 1, null: false
    t.integer  "protected",        limit: 1,   default: 0, null: false
    t.text     "manifest_cache",                           null: false
    t.text     "params",                                   null: false
    t.text     "custom_data",                              null: false
    t.text     "system_data",                              null: false
    t.integer  "checked_out",                  default: 0, null: false
    t.datetime "checked_out_time",                         null: false
    t.integer  "ordering",                     default: 0
    t.integer  "state",                        default: 0
  end

  add_index "z2act_extensions", ["element", "client_id"], name: "element_clientid", using: :btree
  add_index "z2act_extensions", ["element", "folder", "client_id"], name: "element_folder_clientid", using: :btree
  add_index "z2act_extensions", ["type", "element", "folder", "client_id"], name: "extension", using: :btree

  create_table "z2act_facebookall_settings", force: true do |t|
    t.string "setting", null: false
    t.string "value",   null: false
  end

  add_index "z2act_facebookall_settings", ["setting"], name: "setting", unique: true, using: :btree

  create_table "z2act_facebookall_users", id: false, force: true do |t|
    t.integer "id"
    t.string  "facebookall_id"
    t.string  "picture"
    t.string  "access_token"
  end

  create_table "z2act_finder_filters", primary_key: "filter_id", force: true do |t|
    t.string   "title",                                            null: false
    t.string   "alias",                                            null: false
    t.boolean  "state",                             default: true, null: false
    t.datetime "created",                                          null: false
    t.integer  "created_by",                                       null: false
    t.string   "created_by_alias",                                 null: false
    t.datetime "modified",                                         null: false
    t.integer  "modified_by",                       default: 0,    null: false
    t.integer  "checked_out",                       default: 0,    null: false
    t.datetime "checked_out_time",                                 null: false
    t.integer  "map_count",                         default: 0,    null: false
    t.text     "data",                                             null: false
    t.text     "params",           limit: 16777215
  end

  create_table "z2act_finder_links", primary_key: "link_id", force: true do |t|
    t.string   "url",                                                null: false
    t.string   "route",                                              null: false
    t.string   "title"
    t.string   "description"
    t.datetime "indexdate",                                          null: false
    t.string   "md5sum",             limit: 32
    t.boolean  "published",                           default: true, null: false
    t.integer  "state",                               default: 1
    t.integer  "access",                              default: 0
    t.string   "language",           limit: 8,                       null: false
    t.datetime "publish_start_date",                                 null: false
    t.datetime "publish_end_date",                                   null: false
    t.datetime "start_date",                                         null: false
    t.datetime "end_date",                                           null: false
    t.float    "list_price",                          default: 0.0,  null: false
    t.float    "sale_price",                          default: 0.0,  null: false
    t.integer  "type_id",                                            null: false
    t.binary   "object",             limit: 16777215,                null: false
  end

  add_index "z2act_finder_links", ["md5sum"], name: "idx_md5", using: :btree
  add_index "z2act_finder_links", ["published", "state", "access", "publish_start_date", "publish_end_date", "list_price"], name: "idx_published_list", using: :btree
  add_index "z2act_finder_links", ["published", "state", "access", "publish_start_date", "publish_end_date", "sale_price"], name: "idx_published_sale", using: :btree
  add_index "z2act_finder_links", ["title"], name: "idx_title", using: :btree
  add_index "z2act_finder_links", ["type_id"], name: "idx_type", using: :btree
  add_index "z2act_finder_links", ["url"], name: "idx_url", length: {"url"=>75}, using: :btree

  create_table "z2act_finder_links_terms0", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms0", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms0", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms1", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms1", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms1", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms2", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms2", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms2", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms3", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms3", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms3", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms4", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms4", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms4", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms5", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms5", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms5", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms6", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms6", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms6", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms7", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms7", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms7", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms8", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms8", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms8", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_terms9", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_terms9", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_terms9", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_termsa", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_termsa", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_termsa", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_termsb", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_termsb", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_termsb", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_termsc", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_termsc", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_termsc", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_termsd", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_termsd", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_termsd", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_termse", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_termse", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_termse", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_links_termsf", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "term_id", null: false
    t.float   "weight",  null: false
  end

  add_index "z2act_finder_links_termsf", ["link_id", "term_id", "weight"], name: "idx_link_term_weight", using: :btree
  add_index "z2act_finder_links_termsf", ["term_id", "weight"], name: "idx_term_weight", using: :btree

  create_table "z2act_finder_taxonomy", force: true do |t|
    t.integer "parent_id", default: 0,     null: false
    t.string  "title",                     null: false
    t.boolean "state",     default: true,  null: false
    t.boolean "access",    default: false, null: false
    t.boolean "ordering",  default: false, null: false
  end

  add_index "z2act_finder_taxonomy", ["access"], name: "access", using: :btree
  add_index "z2act_finder_taxonomy", ["ordering"], name: "ordering", using: :btree
  add_index "z2act_finder_taxonomy", ["parent_id", "state", "access"], name: "idx_parent_published", using: :btree
  add_index "z2act_finder_taxonomy", ["parent_id"], name: "parent_id", using: :btree
  add_index "z2act_finder_taxonomy", ["state"], name: "state", using: :btree

  create_table "z2act_finder_taxonomy_map", id: false, force: true do |t|
    t.integer "link_id", null: false
    t.integer "node_id", null: false
  end

  add_index "z2act_finder_taxonomy_map", ["link_id"], name: "link_id", using: :btree
  add_index "z2act_finder_taxonomy_map", ["node_id"], name: "node_id", using: :btree

  create_table "z2act_finder_terms", primary_key: "term_id", force: true do |t|
    t.string  "term",     limit: 75,                 null: false
    t.string  "stem",     limit: 75,                 null: false
    t.boolean "common",              default: false, null: false
    t.boolean "phrase",              default: false, null: false
    t.float   "weight",              default: 0.0,   null: false
    t.string  "soundex",  limit: 75,                 null: false
    t.integer "links",               default: 0,     null: false
    t.string  "language", limit: 3,  default: "",    null: false
  end

  add_index "z2act_finder_terms", ["soundex", "phrase"], name: "idx_soundex_phrase", using: :btree
  add_index "z2act_finder_terms", ["stem", "phrase"], name: "idx_stem_phrase", using: :btree
  add_index "z2act_finder_terms", ["term", "phrase"], name: "idx_term_phrase", using: :btree
  add_index "z2act_finder_terms", ["term"], name: "idx_term", unique: true, using: :btree

  create_table "z2act_finder_terms_common", id: false, force: true do |t|
    t.string "term",     limit: 75, null: false
    t.string "language", limit: 3,  null: false
  end

  add_index "z2act_finder_terms_common", ["language"], name: "idx_lang", using: :btree
  add_index "z2act_finder_terms_common", ["term", "language"], name: "idx_word_lang", using: :btree

  create_table "z2act_finder_tokens", id: false, force: true do |t|
    t.string  "term",     limit: 75,                 null: false
    t.string  "stem",     limit: 75,                 null: false
    t.boolean "common",              default: false, null: false
    t.boolean "phrase",              default: false, null: false
    t.float   "weight",              default: 1.0,   null: false
    t.boolean "context",             default: false, null: false
    t.string  "language", limit: 3,  default: "",    null: false
  end

  add_index "z2act_finder_tokens", ["context"], name: "idx_context", using: :hash
  add_index "z2act_finder_tokens", ["term"], name: "idx_word", using: :hash

  create_table "z2act_finder_tokens_aggregate", id: false, force: true do |t|
    t.integer "term_id",                                   null: false
    t.string  "map_suffix",     limit: 1,                  null: false
    t.string  "term",           limit: 75,                 null: false
    t.string  "stem",           limit: 75,                 null: false
    t.boolean "common",                    default: false, null: false
    t.boolean "phrase",                    default: false, null: false
    t.float   "term_weight",                               null: false
    t.boolean "context",                   default: false, null: false
    t.float   "context_weight",                            null: false
    t.float   "total_weight",                              null: false
    t.string  "language",       limit: 3,  default: "",    null: false
  end

  add_index "z2act_finder_tokens_aggregate", ["term"], name: "token", using: :hash
  add_index "z2act_finder_tokens_aggregate", ["term_id"], name: "keyword_id", using: :hash

  create_table "z2act_finder_types", force: true do |t|
    t.string "title", limit: 100, null: false
    t.string "mime",  limit: 100, null: false
  end

  add_index "z2act_finder_types", ["title"], name: "title", unique: true, using: :btree

  create_table "z2act_grart_config", force: true do |t|
    t.string "key",   limit: 45, null: false
    t.string "value", limit: 45, null: false
  end

  create_table "z2act_languages", primary_key: "lang_id", force: true do |t|
    t.string  "lang_code",    limit: 7,                 null: false
    t.string  "title",        limit: 50,                null: false
    t.string  "title_native", limit: 50,                null: false
    t.string  "sef",          limit: 50,                null: false
    t.string  "image",        limit: 50,                null: false
    t.string  "description",  limit: 512,               null: false
    t.text    "metakey",                                null: false
    t.text    "metadesc",                               null: false
    t.string  "sitename",     limit: 1024, default: "", null: false
    t.integer "published",                 default: 0,  null: false
    t.integer "access",                    default: 0,  null: false
    t.integer "ordering",                  default: 0,  null: false
  end

  add_index "z2act_languages", ["access"], name: "idx_access", using: :btree
  add_index "z2act_languages", ["image"], name: "idx_image", unique: true, using: :btree
  add_index "z2act_languages", ["lang_code"], name: "idx_langcode", unique: true, using: :btree
  add_index "z2act_languages", ["ordering"], name: "idx_ordering", using: :btree
  add_index "z2act_languages", ["sef"], name: "idx_sef", unique: true, using: :btree

  create_table "z2act_menu", force: true do |t|
    t.string    "menutype",          limit: 24,                null: false
    t.string    "title",                                       null: false
    t.string    "alias",                                       null: false
    t.string    "note",                           default: "", null: false
    t.string    "path",              limit: 1024,              null: false
    t.string    "link",              limit: 1024,              null: false
    t.string    "type",              limit: 16,                null: false
    t.integer   "published",         limit: 1,    default: 0,  null: false
    t.integer   "parent_id",                      default: 1,  null: false
    t.integer   "level",                          default: 0,  null: false
    t.integer   "component_id",                   default: 0,  null: false
    t.integer   "checked_out",                    default: 0,  null: false
    t.timestamp "checked_out_time",                            null: false
    t.integer   "browserNav",        limit: 1,    default: 0,  null: false
    t.integer   "access",                         default: 0,  null: false
    t.string    "img",                                         null: false
    t.integer   "template_style_id",              default: 0,  null: false
    t.text      "params",                                      null: false
    t.integer   "lft",                            default: 0,  null: false
    t.integer   "rgt",                            default: 0,  null: false
    t.integer   "home",              limit: 1,    default: 0,  null: false
    t.string    "language",          limit: 7,    default: "", null: false
    t.integer   "client_id",         limit: 1,    default: 0,  null: false
  end

  add_index "z2act_menu", ["alias"], name: "idx_alias", using: :btree
  add_index "z2act_menu", ["client_id", "parent_id", "alias", "language"], name: "idx_client_id_parent_id_alias_language", unique: true, using: :btree
  add_index "z2act_menu", ["component_id", "menutype", "published", "access"], name: "idx_componentid", using: :btree
  add_index "z2act_menu", ["language"], name: "idx_language", using: :btree
  add_index "z2act_menu", ["lft", "rgt"], name: "idx_left_right", using: :btree
  add_index "z2act_menu", ["menutype"], name: "idx_menutype", using: :btree
  add_index "z2act_menu", ["path"], name: "idx_path", length: {"path"=>255}, using: :btree

  create_table "z2act_menu_types", force: true do |t|
    t.string "menutype",    limit: 24,              null: false
    t.string "title",       limit: 48,              null: false
    t.string "description",            default: "", null: false
  end

  add_index "z2act_menu_types", ["menutype"], name: "idx_menutype", unique: true, using: :btree

  create_table "z2act_messages", primary_key: "message_id", force: true do |t|
    t.integer  "user_id_from",           default: 0,     null: false
    t.integer  "user_id_to",             default: 0,     null: false
    t.integer  "folder_id",    limit: 1, default: 0,     null: false
    t.datetime "date_time",                              null: false
    t.boolean  "state",                  default: false, null: false
    t.boolean  "priority",               default: false, null: false
    t.string   "subject",                default: "",    null: false
    t.text     "message",                                null: false
  end

  add_index "z2act_messages", ["user_id_to", "state"], name: "useridto_state", using: :btree

  create_table "z2act_messages_cfg", id: false, force: true do |t|
    t.integer "user_id",               default: 0,  null: false
    t.string  "cfg_name",  limit: 100, default: "", null: false
    t.string  "cfg_value",             default: "", null: false
  end

  add_index "z2act_messages_cfg", ["user_id", "cfg_name"], name: "idx_user_var_name", unique: true, using: :btree

  create_table "z2act_mijosef_bookmarks_backup", force: true do |t|
    t.string  "name",                    default: "",   null: false
    t.text    "html",                                   null: false
    t.string  "btype",       limit: 20,  default: "",   null: false
    t.string  "placeholder", limit: 150, default: "",   null: false
    t.boolean "published",               default: true, null: false
  end

  create_table "z2act_mijosef_extensions_backup", force: true do |t|
    t.string "name",                 default: "", null: false
    t.string "extension", limit: 45, default: "", null: false
    t.text   "params",                            null: false
  end

  add_index "z2act_mijosef_extensions_backup", ["extension"], name: "extension", unique: true, using: :btree

  create_table "z2act_mijosef_ilinks_backup", force: true do |t|
    t.string  "word",                 default: "",    null: false
    t.string  "link",                 default: "",    null: false
    t.boolean "published",            default: true,  null: false
    t.boolean "nofollow",             default: false, null: false
    t.boolean "iblank",               default: false, null: false
    t.string  "ilimit",    limit: 30, default: "10",  null: false
  end

  add_index "z2act_mijosef_ilinks_backup", ["word"], name: "word", unique: true, using: :btree

  create_table "z2act_mijosef_metadata_backup", force: true do |t|
    t.string  "url_sef",                default: "",   null: false
    t.boolean "published",              default: true, null: false
    t.string  "title",                  default: "",   null: false
    t.string  "description",            default: "",   null: false
    t.string  "keywords",               default: "",   null: false
    t.string  "lang",        limit: 30, default: "",   null: false
    t.string  "robots",      limit: 30, default: "",   null: false
    t.string  "googlebot",   limit: 30, default: "",   null: false
    t.string  "canonical",              default: "",   null: false
  end

  add_index "z2act_mijosef_metadata_backup", ["url_sef"], name: "url_sef", unique: true, using: :btree

  create_table "z2act_mijosef_sitemap_backup", force: true do |t|
    t.string  "url_sef",              default: "",   null: false
    t.string  "title",                default: "",   null: false
    t.boolean "published",            default: true, null: false
    t.date    "sdate",                               null: false
    t.string  "frequency", limit: 30, default: "",   null: false
    t.string  "priority",  limit: 10, default: "",   null: false
    t.integer "sparent",              default: 0,    null: false
    t.integer "sorder",               default: 1000, null: false
  end

  add_index "z2act_mijosef_sitemap_backup", ["url_sef"], name: "url_sef", unique: true, using: :btree

  create_table "z2act_mijosef_tags_backup", force: true do |t|
    t.string  "title",       limit: 150, default: "",   null: false
    t.string  "alias",       limit: 150, default: "",   null: false
    t.string  "description", limit: 150, default: "",   null: false
    t.boolean "published",               default: true, null: false
    t.integer "ordering",                default: 0,    null: false
    t.integer "hits",                    default: 0,    null: false
  end

  add_index "z2act_mijosef_tags_backup", ["title"], name: "title", unique: true, using: :btree

  create_table "z2act_mijosef_tags_map_backup", id: false, force: true do |t|
    t.string "url_sef",             default: "", null: false
    t.string "tag",     limit: 150, default: "", null: false
  end

  create_table "z2act_mijosef_urls_backup", force: true do |t|
    t.string   "url_sef",  default: "",    null: false
    t.string   "url_real", default: "",    null: false
    t.datetime "cdate",                    null: false
    t.datetime "mdate",                    null: false
    t.boolean  "used",     default: false, null: false
    t.integer  "hits",     default: 0,     null: false
    t.text     "source",                   null: false
    t.text     "params",                   null: false
  end

  add_index "z2act_mijosef_urls_backup", ["url_real"], name: "url_real", unique: true, using: :btree
  add_index "z2act_mijosef_urls_backup", ["url_sef"], name: "url_sef", using: :btree
  add_index "z2act_mijosef_urls_backup", ["used"], name: "used", using: :btree

  create_table "z2act_mijosef_urls_moved_backup", force: true do |t|
    t.string   "url_new",   default: "",   null: false
    t.string   "url_old",   default: "",   null: false
    t.boolean  "published", default: true, null: false
    t.integer  "hits",      default: 0,    null: false
    t.datetime "last_hit",                 null: false
  end

  add_index "z2act_mijosef_urls_moved_backup", ["url_new"], name: "url_new", using: :btree
  add_index "z2act_mijosef_urls_moved_backup", ["url_old"], name: "url_old", unique: true, using: :btree

  create_table "z2act_modules", force: true do |t|
    t.string   "title",            limit: 100, default: "",    null: false
    t.string   "note",                         default: "",    null: false
    t.text     "content",                                      null: false
    t.integer  "ordering",                     default: 0,     null: false
    t.string   "position",         limit: 50,  default: "",    null: false
    t.integer  "checked_out",                  default: 0,     null: false
    t.datetime "checked_out_time",                             null: false
    t.datetime "publish_up",                                   null: false
    t.datetime "publish_down",                                 null: false
    t.boolean  "published",                    default: false, null: false
    t.string   "module",           limit: 50
    t.integer  "access",                       default: 0,     null: false
    t.integer  "showtitle",        limit: 1,   default: 1,     null: false
    t.text     "params",                                       null: false
    t.integer  "client_id",        limit: 1,   default: 0,     null: false
    t.string   "language",         limit: 7,                   null: false
  end

  add_index "z2act_modules", ["language"], name: "idx_language", using: :btree
  add_index "z2act_modules", ["module", "published"], name: "newsfeeds", using: :btree
  add_index "z2act_modules", ["published", "access"], name: "published", using: :btree

  create_table "z2act_modules_menu", id: false, force: true do |t|
    t.integer "moduleid", default: 0, null: false
    t.integer "menuid",   default: 0, null: false
  end

  create_table "z2act_newsfeeds", force: true do |t|
    t.integer  "catid",                        default: 0,     null: false
    t.string   "name",             limit: 100, default: "",    null: false
    t.string   "alias",                        default: "",    null: false
    t.string   "link",             limit: 200, default: "",    null: false
    t.boolean  "published",                    default: false, null: false
    t.integer  "numarticles",                  default: 1,     null: false
    t.integer  "cache_time",                   default: 3600,  null: false
    t.integer  "checked_out",                  default: 0,     null: false
    t.datetime "checked_out_time",                             null: false
    t.integer  "ordering",                     default: 0,     null: false
    t.integer  "rtl",              limit: 1,   default: 0,     null: false
    t.integer  "access",                       default: 0,     null: false
    t.string   "language",         limit: 7,   default: "",    null: false
    t.text     "params",                                       null: false
    t.datetime "created",                                      null: false
    t.integer  "created_by",                   default: 0,     null: false
    t.string   "created_by_alias",             default: "",    null: false
    t.datetime "modified",                                     null: false
    t.integer  "modified_by",                  default: 0,     null: false
    t.text     "metakey",                                      null: false
    t.text     "metadesc",                                     null: false
    t.text     "metadata",                                     null: false
    t.string   "xreference",       limit: 50,                  null: false
    t.datetime "publish_up",                                   null: false
    t.datetime "publish_down",                                 null: false
    t.text     "description",                                  null: false
    t.integer  "version",                      default: 1,     null: false
    t.integer  "hits",                         default: 0,     null: false
    t.text     "images",                                       null: false
  end

  add_index "z2act_newsfeeds", ["access"], name: "idx_access", using: :btree
  add_index "z2act_newsfeeds", ["catid"], name: "idx_catid", using: :btree
  add_index "z2act_newsfeeds", ["checked_out"], name: "idx_checkout", using: :btree
  add_index "z2act_newsfeeds", ["created_by"], name: "idx_createdby", using: :btree
  add_index "z2act_newsfeeds", ["language"], name: "idx_language", using: :btree
  add_index "z2act_newsfeeds", ["published"], name: "idx_state", using: :btree
  add_index "z2act_newsfeeds", ["xreference"], name: "idx_xreference", using: :btree

  create_table "z2act_newsletter_category", force: true do |t|
    t.string  "value",            limit: 30, null: false
    t.integer "require_register",            null: false
  end

  create_table "z2act_newsletter_category_subscription", force: true do |t|
    t.integer "ns_id",          null: false
    t.integer "ns_category_id", null: false
  end

  create_table "z2act_newsletter_subscription", force: true do |t|
    t.string  "email",      limit: 50, null: false
    t.string  "name",       limit: 50, null: false
    t.integer "subscribed",            null: false
    t.integer "registered",            null: false
  end

  create_table "z2act_overrider", force: true do |t|
    t.string "constant", null: false
    t.text   "string",   null: false
    t.string "file",     null: false
  end

  create_table "z2act_plg_easyfrontendseo", id: false, force: true do |t|
    t.text "url",         limit: 255, null: false
    t.text "title",       limit: 255, null: false
    t.text "description",             null: false
    t.text "keywords",    limit: 255, null: false
    t.text "generator",   limit: 255, null: false
    t.text "robots",      limit: 255, null: false
  end

  create_table "z2act_posts", primary_key: "post_id", force: true do |t|
    t.string   "image_url",               default: "",  null: false
    t.string   "video_url",               default: "",  null: false
    t.integer  "sender_id",               default: 0,   null: false
    t.integer  "receiver_id",             default: 0,   null: false
    t.text     "post_content",                          null: false
    t.datetime "post_date",                             null: false
    t.string   "ip",           limit: 40, default: "0", null: false
    t.text     "param"
    t.integer  "status",       limit: 1,  default: 1,   null: false
    t.integer  "likescount"
  end

  add_index "z2act_posts", ["sender_id"], name: "user_id", using: :btree

  create_table "z2act_product_featured", force: true do |t|
    t.integer "artwork_image_id", null: false
    t.integer "order",            null: false
    t.integer "category_id",      null: false
    t.integer "product_id",       null: false
  end

  create_table "z2act_redirect_links", force: true do |t|
    t.string   "old_url",                               null: false
    t.string   "new_url",                               null: false
    t.string   "referer",       limit: 150,             null: false
    t.string   "comment",                               null: false
    t.integer  "hits",                      default: 0, null: false
    t.integer  "published",     limit: 1,               null: false
    t.datetime "created_date",                          null: false
    t.datetime "modified_date",                         null: false
  end

  add_index "z2act_redirect_links", ["modified_date"], name: "idx_link_modifed", using: :btree
  add_index "z2act_redirect_links", ["old_url"], name: "idx_link_old", unique: true, using: :btree

  create_table "z2act_sc_config", force: true do |t|
    t.string  "keyword",     limit: 32,             null: false
    t.string  "description",                        null: false
    t.text    "setting",                            null: false
    t.integer "cfgset",                 default: 0, null: false
    t.string  "type",        limit: 8,              null: false
    t.text    "indopts",                            null: false
    t.integer "sh",                                 null: false
    t.integer "sv",                                 null: false
    t.string  "pagename",    limit: 32,             null: false
  end

  add_index "z2act_sc_config", ["keyword"], name: "kw", using: :btree

  create_table "z2act_sc_downloads", force: true do |t|
    t.string  "filename"
    t.string  "paymentkey"
    t.integer "datetime"
  end

  create_table "z2act_sc_fields", force: true do |t|
    t.string  "name",          limit: 32
    t.string  "caption"
    t.string  "type",          limit: 16
    t.string  "length",        limit: 11
    t.string  "classname",     limit: 64
    t.integer "required"
    t.integer "ordering"
    t.integer "published"
    t.string  "checkfunction", limit: 64
    t.text    "fieldcontents"
  end

  create_table "z2act_sc_odetails", force: true do |t|
    t.integer "orderid"
    t.string  "prodcode",  limit: 10
    t.integer "qty"
    t.float   "unitprice"
    t.float   "total"
    t.string  "shorttext"
    t.string  "option"
  end

  create_table "z2act_sc_orders", force: true do |t|
    t.string  "name"
    t.string  "email"
    t.text    "address"
    t.string  "codepostal",   limit: 15
    t.string  "city",         limit: 32
    t.string  "telephone",    limit: 32
    t.string  "ipaddress",    limit: 16
    t.text    "customfields"
    t.integer "orderdt"
    t.float   "total"
    t.string  "status",       limit: 16
    t.float   "tax"
    t.integer "archive"
    t.string  "shipCost",     limit: 10
    t.string  "shipRegion"
    t.integer "j_user_id"
    t.string  "ordercode"
    t.string  "orderlink"
    t.string  "paymentcode"
  end

  create_table "z2act_sc_prodoptiongroups", force: true do |t|
    t.string  "prodcode",  limit: 32, null: false
    t.string  "title",                null: false
    t.integer "showas",               null: false
    t.integer "disporder",            null: false
    t.integer "productid",            null: false
  end

  create_table "z2act_sc_productoptions", force: true do |t|
    t.integer "optgroupid",  null: false
    t.string  "description", null: false
    t.string  "formula",     null: false
    t.string  "caption",     null: false
    t.integer "defselect",   null: false
    t.integer "disporder",   null: false
  end

  create_table "z2act_sc_products", force: true do |t|
    t.string  "prodcode",     limit: 64
    t.string  "shorttext"
    t.integer "av_qty"
    t.float   "unitprice"
    t.integer "published"
    t.string  "optionstitle", limit: 32
    t.text    "options"
    t.integer "showas"
    t.string  "category"
    t.integer "downloadable"
    t.string  "filename"
    t.string  "shippoints",   limit: 10
    t.float   "shipwidth"
    t.float   "shipheight"
    t.float   "shiplength"
    t.float   "shipweight"
    t.integer "userid"
  end

  create_table "z2act_schemas", id: false, force: true do |t|
    t.integer "extension_id",            null: false
    t.string  "version_id",   limit: 20, null: false
  end

  create_table "z2act_session", primary_key: "session_id", force: true do |t|
    t.integer "client_id", limit: 1,        default: 0,  null: false
    t.integer "guest",     limit: 1,        default: 1
    t.string  "time",      limit: 14,       default: ""
    t.text    "data",      limit: 16777215
    t.integer "userid",                     default: 0
    t.string  "username",  limit: 150,      default: ""
  end

  add_index "z2act_session", ["time"], name: "time", using: :btree
  add_index "z2act_session", ["userid"], name: "userid", using: :btree

  create_table "z2act_tags", force: true do |t|
    t.integer "artwork_id",            null: false
    t.string  "tag_name",   limit: 30, null: false
  end

  create_table "z2act_template_styles", force: true do |t|
    t.string  "template",  limit: 50, default: "",    null: false
    t.boolean "client_id",            default: false, null: false
    t.string  "home",      limit: 7,  default: "0",   null: false
    t.string  "title",                default: "",    null: false
    t.text    "params",                               null: false
  end

  add_index "z2act_template_styles", ["home"], name: "idx_home", using: :btree
  add_index "z2act_template_styles", ["template"], name: "idx_template", using: :btree

  create_table "z2act_update_sites", primary_key: "update_site_id", force: true do |t|
    t.string  "name",                 limit: 100, default: ""
    t.string  "type",                 limit: 20,  default: ""
    t.text    "location",                                      null: false
    t.integer "enabled",                          default: 0
    t.integer "last_check_timestamp", limit: 8,   default: 0
  end

  create_table "z2act_update_sites_extensions", id: false, force: true do |t|
    t.integer "update_site_id", default: 0, null: false
    t.integer "extension_id",   default: 0, null: false
  end

  create_table "z2act_updates", primary_key: "update_id", force: true do |t|
    t.integer "update_site_id",             default: 0
    t.integer "extension_id",               default: 0
    t.string  "name",           limit: 100, default: ""
    t.text    "description",                             null: false
    t.string  "element",        limit: 100, default: ""
    t.string  "type",           limit: 20,  default: ""
    t.string  "folder",         limit: 20,  default: ""
    t.integer "client_id",      limit: 1,   default: 0
    t.string  "version",        limit: 10,  default: ""
    t.text    "data",                                    null: false
    t.text    "detailsurl",                              null: false
    t.text    "infourl",                                 null: false
  end

  create_table "z2act_user_notes", force: true do |t|
    t.integer  "user_id",                      default: 0,  null: false
    t.integer  "catid",                        default: 0,  null: false
    t.string   "subject",          limit: 100, default: "", null: false
    t.text     "body",                                      null: false
    t.integer  "state",            limit: 1,   default: 0,  null: false
    t.integer  "checked_out",                  default: 0,  null: false
    t.datetime "checked_out_time",                          null: false
    t.integer  "created_user_id",              default: 0,  null: false
    t.datetime "created_time",                              null: false
    t.integer  "modified_user_id",                          null: false
    t.datetime "modified_time",                             null: false
    t.datetime "review_time",                               null: false
    t.datetime "publish_up",                                null: false
    t.datetime "publish_down",                              null: false
  end

  add_index "z2act_user_notes", ["catid"], name: "idx_category_id", using: :btree
  add_index "z2act_user_notes", ["user_id"], name: "idx_user_id", using: :btree

  create_table "z2act_user_profiles", id: false, force: true do |t|
    t.integer "user_id",                               null: false
    t.string  "profile_key",   limit: 100,             null: false
    t.string  "profile_value",                         null: false
    t.integer "ordering",                  default: 0, null: false
  end

  add_index "z2act_user_profiles", ["user_id", "profile_key"], name: "idx_user_id_profile_key", unique: true, using: :btree

  create_table "z2act_user_usergroup_map", id: false, force: true do |t|
    t.integer "user_id",  default: 0, null: false
    t.integer "group_id", default: 0, null: false
  end

  create_table "z2act_usergroups", force: true do |t|
    t.integer "parent_id",             default: 0,  null: false
    t.integer "lft",                   default: 0,  null: false
    t.integer "rgt",                   default: 0,  null: false
    t.string  "title",     limit: 100, default: "", null: false
  end

  add_index "z2act_usergroups", ["lft", "rgt"], name: "idx_usergroup_nested_set_lookup", using: :btree
  add_index "z2act_usergroups", ["parent_id", "title"], name: "idx_usergroup_parent_title_lookup", unique: true, using: :btree
  add_index "z2act_usergroups", ["parent_id"], name: "idx_usergroup_adjacency_lookup", using: :btree
  add_index "z2act_usergroups", ["title"], name: "idx_usergroup_title_lookup", using: :btree

  create_table "z2act_users", force: true do |t|
    t.string    "name",                      default: "",                    null: false
    t.string    "username",      limit: 150, default: "",                    null: false
    t.string    "email",         limit: 100, default: "",                    null: false
    t.string    "password",      limit: 100, default: "",                    null: false
    t.integer   "block",         limit: 1,   default: 0,                     null: false
    t.integer   "sendEmail",     limit: 1,   default: 0
    t.timestamp "registerDate",              default: '2014-02-01 00:00:00', null: false
    t.timestamp "lastvisitDate",             default: '2014-02-01 00:00:00', null: false
    t.string    "activation",    limit: 100, default: "",                    null: false
    t.text      "params",                                                    null: false
    t.timestamp "lastResetTime",             default: '2014-02-01 00:00:00', null: false
    t.integer   "resetCount",                default: 0,                     null: false
    t.string    "usertype",      limit: 45,                                  null: false
    t.integer   "thumbnail",                 default: 0
    t.string    "token"
  end

  add_index "z2act_users", ["block"], name: "idx_block", using: :btree
  add_index "z2act_users", ["email"], name: "email", using: :btree
  add_index "z2act_users", ["name"], name: "idx_name", using: :btree
  add_index "z2act_users", ["username"], name: "username", using: :btree

  create_table "z2act_viewlevels", force: true do |t|
    t.string  "title",    limit: 100,  default: "", null: false
    t.integer "ordering",              default: 0,  null: false
    t.string  "rules",    limit: 5120,              null: false
  end

  add_index "z2act_viewlevels", ["title"], name: "idx_assetgroup_title_lookup", unique: true, using: :btree

  create_table "z2act_weblinks", force: true do |t|
    t.integer  "catid",                        default: 0,     null: false
    t.string   "title",            limit: 250, default: "",    null: false
    t.string   "alias",                        default: "",    null: false
    t.string   "url",              limit: 250, default: "",    null: false
    t.text     "description",                                  null: false
    t.integer  "hits",                         default: 0,     null: false
    t.boolean  "state",                        default: false, null: false
    t.integer  "checked_out",                  default: 0,     null: false
    t.datetime "checked_out_time",                             null: false
    t.integer  "ordering",                     default: 0,     null: false
    t.integer  "access",                       default: 1,     null: false
    t.text     "params",                                       null: false
    t.string   "language",         limit: 7,   default: "",    null: false
    t.datetime "created",                                      null: false
    t.integer  "created_by",                   default: 0,     null: false
    t.string   "created_by_alias",             default: "",    null: false
    t.datetime "modified",                                     null: false
    t.integer  "modified_by",                  default: 0,     null: false
    t.text     "metakey",                                      null: false
    t.text     "metadesc",                                     null: false
    t.text     "metadata",                                     null: false
    t.integer  "featured",         limit: 1,   default: 0,     null: false
    t.string   "xreference",       limit: 50,                  null: false
    t.datetime "publish_up",                                   null: false
    t.datetime "publish_down",                                 null: false
    t.integer  "version",                      default: 1,     null: false
    t.text     "images",                                       null: false
  end

  add_index "z2act_weblinks", ["access"], name: "idx_access", using: :btree
  add_index "z2act_weblinks", ["catid"], name: "idx_catid", using: :btree
  add_index "z2act_weblinks", ["checked_out"], name: "idx_checkout", using: :btree
  add_index "z2act_weblinks", ["created_by"], name: "idx_createdby", using: :btree
  add_index "z2act_weblinks", ["featured", "catid"], name: "idx_featured_catid", using: :btree
  add_index "z2act_weblinks", ["language"], name: "idx_language", using: :btree
  add_index "z2act_weblinks", ["state"], name: "idx_state", using: :btree
  add_index "z2act_weblinks", ["xreference"], name: "idx_xreference", using: :btree

end
