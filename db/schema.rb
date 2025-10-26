# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_26_032224) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "submission_set_entries", force: :cascade do |t|
    t.bigint "submission_set_id", null: false
    t.bigint "submission_id", null: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submission_id"], name: "index_submission_set_entries_on_submission_id"
    t.index ["submission_set_id"], name: "index_submission_set_entries_on_submission_set_id"
  end

  create_table "submission_sets", force: :cascade do |t|
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_submission_sets_on_owner_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.text "content"
    t.integer "status"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "user"
    t.string "password_digest"
    t.string "email"
    t.string "token"
    t.string "google_id"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "submission_set_entries", "submission_sets"
  add_foreign_key "submission_set_entries", "submissions"
  add_foreign_key "submission_sets", "users", column: "owner_id"
  add_foreign_key "submissions", "users"
end
