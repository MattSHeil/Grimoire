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

ActiveRecord::Schema.define(version: 20160929213008) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "labeled_mangas", force: :cascade do |t|
    t.integer  "manga_id"
    t.integer  "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label_id"], name: "index_labeled_mangas_on_label_id", using: :btree
    t.index ["manga_id"], name: "index_labeled_mangas_on_manga_id", using: :btree
  end

  create_table "labels", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "last_updates", force: :cascade do |t|
    t.string   "title"
    t.string   "link_to_page"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "manga_imgs", force: :cascade do |t|
    t.integer  "manga_id"
    t.string   "cover_img_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["manga_id"], name: "index_manga_imgs_on_manga_id", using: :btree
  end

  create_table "mangas", force: :cascade do |t|
    t.string   "title"
    t.string   "link_to_page"
    t.integer  "total_chapters"
    t.string   "posted_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "mangas_artists", force: :cascade do |t|
    t.integer  "manga_id"
    t.integer  "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_mangas_artists_on_artist_id", using: :btree
    t.index ["manga_id"], name: "index_mangas_artists_on_manga_id", using: :btree
  end

  create_table "mangas_authors", force: :cascade do |t|
    t.integer  "manga_id"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_mangas_authors_on_author_id", using: :btree
    t.index ["manga_id"], name: "index_mangas_authors_on_manga_id", using: :btree
  end

  create_table "user_mangas", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "manga_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "updated",    default: false
    t.index ["manga_id"], name: "index_user_mangas_on_manga_id", using: :btree
    t.index ["user_id"], name: "index_user_mangas_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "labeled_mangas", "labels"
  add_foreign_key "labeled_mangas", "mangas"
  add_foreign_key "manga_imgs", "mangas"
  add_foreign_key "mangas_artists", "artists"
  add_foreign_key "mangas_artists", "mangas"
  add_foreign_key "mangas_authors", "authors"
  add_foreign_key "mangas_authors", "mangas"
  add_foreign_key "user_mangas", "mangas"
  add_foreign_key "user_mangas", "users"
end
