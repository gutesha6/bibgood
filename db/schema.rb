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

ActiveRecord::Schema.define(version: 20170706084940) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "exercizes", id: :serial, force: :cascade do |t|
    t.integer "lesson_id"
    t.string "body"
    t.text "notes"
    t.integer "difficulty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lesson_version_id"
    t.index ["lesson_id"], name: "index_exercizes_on_lesson_id"
  end

  create_table "friendships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "lessons", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "video_id"
    t.string "image"
    t.index ["slug"], name: "index_lessons_on_slug"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "position"
    t.string "body"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "lesson_version_id"
    t.index ["lesson_id"], name: "index_questions_on_lesson_id"
  end

  create_table "studies", id: :serial, force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.integer "lesson_version_id"
    t.integer "study_users_count", default: 0
    t.index ["lesson_id"], name: "index_studies_on_lesson_id"
    t.index ["user_id"], name: "index_studies_on_user_id"
  end

  create_table "study_exercizes", id: :serial, force: :cascade do |t|
    t.integer "study_id"
    t.integer "exercize_id"
    t.integer "exercize_version_id"
    t.index ["exercize_id"], name: "index_study_exercizes_on_exercize_id"
    t.index ["study_id"], name: "index_study_exercizes_on_study_id"
  end

  create_table "study_questions", id: :serial, force: :cascade do |t|
    t.integer "study_id"
    t.integer "question_id"
    t.integer "question_version_id"
    t.index ["question_id"], name: "index_study_questions_on_question_id"
    t.index ["study_id"], name: "index_study_questions_on_study_id"
  end

  create_table "study_requests", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "study_id"
    t.string "title"
    t.text "body"
    t.integer "status", default: 0
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_id"], name: "index_study_requests_on_study_id"
    t.index ["user_id"], name: "index_study_requests_on_user_id"
  end

  create_table "study_transitions", id: :serial, force: :cascade do |t|
    t.string "to_state", null: false
    t.json "metadata", default: {}
    t.integer "sort_key", null: false
    t.integer "study_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_id", "most_recent"], name: "index_study_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["study_id", "sort_key"], name: "index_study_transitions_parent_sort", unique: true
  end

  create_table "study_user_exercize_transitions", force: :cascade do |t|
    t.string "to_state", null: false
    t.text "metadata", default: "{}"
    t.integer "sort_key", null: false
    t.integer "study_user_exercize_id", null: false
    t.boolean "most_recent", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_user_exercize_id", "most_recent"], name: "index_study_user_exercize_transitions_parent_most_recent", unique: true, where: "most_recent"
    t.index ["study_user_exercize_id", "sort_key"], name: "index_study_user_exercize_transitions_parent_sort", unique: true
  end

  create_table "study_user_exercizes", id: :serial, force: :cascade do |t|
    t.integer "study_user_id"
    t.integer "study_exercize_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_exercize_id"], name: "index_study_user_exercizes_on_study_exercize_id"
    t.index ["study_user_id"], name: "index_study_user_exercizes_on_study_user_id"
  end

  create_table "study_user_questions", id: :serial, force: :cascade do |t|
    t.integer "study_user_id"
    t.integer "study_question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_question_id"], name: "index_study_user_questions_on_study_question_id"
    t.index ["study_user_id"], name: "index_study_user_questions_on_study_user_id"
  end

  create_table "study_users", id: :serial, force: :cascade do |t|
    t.integer "study_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["study_id"], name: "index_study_users_on_study_id"
    t.index ["user_id"], name: "index_study_users_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "provider"
    t.string "uid"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.datetime "deleted_at"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "comments", "users"
  add_foreign_key "exercizes", "lessons"
  add_foreign_key "exercizes", "versions", column: "lesson_version_id"
  add_foreign_key "friendships", "users"
  add_foreign_key "friendships", "users", column: "friend_id"
  add_foreign_key "questions", "lessons"
  add_foreign_key "questions", "versions", column: "lesson_version_id"
  add_foreign_key "studies", "lessons"
  add_foreign_key "studies", "users"
  add_foreign_key "studies", "versions", column: "lesson_version_id"
  add_foreign_key "study_exercizes", "exercizes"
  add_foreign_key "study_exercizes", "studies"
  add_foreign_key "study_exercizes", "versions", column: "exercize_version_id"
  add_foreign_key "study_questions", "questions"
  add_foreign_key "study_questions", "studies"
  add_foreign_key "study_questions", "versions", column: "question_version_id"
  add_foreign_key "study_requests", "studies"
  add_foreign_key "study_requests", "users"
  add_foreign_key "study_user_exercizes", "study_exercizes"
  add_foreign_key "study_user_exercizes", "study_users"
  add_foreign_key "study_user_questions", "study_questions"
  add_foreign_key "study_user_questions", "study_users"
  add_foreign_key "study_users", "studies"
  add_foreign_key "study_users", "users"
end
