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

ActiveRecord::Schema.define(version: 2021_07_06_100906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.integer "province"
    t.string "zip_code"
    t.string "country"
    t.integer "category"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "filled_survey_id", null: false
    t.string "content"
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "option_id"
    t.index ["filled_survey_id"], name: "index_answers_on_filled_survey_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "time"
    t.bigint "doctor_id", null: false
    t.bigint "participant_id", null: false
    t.integer "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["participant_id"], name: "index_appointments_on_participant_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.integer "contribution_type"
    t.date "end_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "cycles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "annual_paid_on"
    t.datetime "current_study_renews_on"
    t.integer "monthly_cycle_start_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "aasm_state"
    t.index ["user_id"], name: "index_cycles_on_user_id"
  end

  create_table "dispensaries", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "avatar"
    t.integer "category"
    t.string "documents"
    t.boolean "verified"
    t.boolean "open"
    t.decimal "lat"
    t.decimal "lng"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "manager_id", null: false
    t.index ["manager_id"], name: "index_dispensaries_on_manager_id"
  end

  create_table "filled_surveys", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.string "state", default: "pending"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "score"
    t.index ["survey_id"], name: "index_filled_surveys_on_survey_id"
    t.index ["user_id"], name: "index_filled_surveys_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "material_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "materials", force: :cascade do |t|
    t.bigint "material_type_id", null: false
    t.string "name"
    t.string "description"
    t.integer "weight"
    t.integer "thc"
    t.integer "cbd"
    t.integer "terpene"
    t.boolean "drought", default: false
    t.boolean "oil", default: false
    t.boolean "edible", default: false
    t.integer "cost"
    t.bigint "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "aasm_state"
    t.index ["material_type_id"], name: "index_materials_on_material_type_id"
    t.index ["owner_id"], name: "index_materials_on_owner_id"
  end

  create_table "order_materials", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "material_id", null: false
    t.integer "amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["material_id"], name: "index_order_materials_on_material_id"
    t.index ["order_id"], name: "index_order_materials_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "show_in_menu", default: false
    t.string "slug"
    t.integer "position"
    t.boolean "inner", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "status"
    t.bigint "user_id", null: false
    t.datetime "post_date"
    t.string "image"
    t.string "slug"
    t.boolean "inner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.string "nick_name"
    t.string "pesel"
    t.integer "gender"
    t.string "skills"
    t.string "contact_number"
    t.string "avatar"
    t.date "birth_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "onboarded", default: false
    t.boolean "verified", default: false
    t.boolean "locked", default: false
    t.integer "quota_max_dry", default: 0
    t.integer "quota_left_dry", default: 0
    t.integer "credits", default: 0
    t.string "aasm_state"
    t.string "old_state"
    t.string "risk"
    t.bigint "doctor_id"
    t.integer "risk_calculated"
    t.integer "quota_max_oil", default: 0
    t.integer "quota_left_oil", default: 0
    t.index ["doctor_id"], name: "index_profiles_on_doctor_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "question_options", force: :cascade do |t|
    t.string "name"
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "display"
    t.integer "score", default: 0
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "question_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "question_type_id", null: false
    t.bigint "survey_id", null: false
    t.integer "min"
    t.integer "max"
    t.string "placeholder"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "order", default: 0
    t.index ["question_type_id"], name: "index_questions_on_question_type_id"
    t.index ["survey_id"], name: "index_questions_on_survey_id"
  end

  create_table "slots", force: :cascade do |t|
    t.boolean "booked", default: false
    t.integer "day", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.datetime "time"
    t.index ["user_id"], name: "index_slots_on_user_id"
  end

  create_table "studies", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id", null: false
    t.integer "max"
    t.integer "fee"
    t.integer "cycle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_studies_on_user_id"
  end

  create_table "study_participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "study_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["study_id"], name: "index_study_participations_on_study_id"
    t.index ["user_id"], name: "index_study_participations_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "hidden", default: false
    t.boolean "required", default: false
    t.string "internal_name"
    t.bigint "study_id", default: 1, null: false
    t.index ["study_id"], name: "index_surveys_on_study_id"
    t.index ["user_id"], name: "index_surveys_on_user_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "sender_material_id", null: false
    t.bigint "receiver_material_id", null: false
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.integer "weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["receiver_id"], name: "index_transfers_on_receiver_id"
    t.index ["receiver_material_id"], name: "index_transfers_on_receiver_material_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
    t.index ["sender_material_id"], name: "index_transfers_on_sender_material_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type"
    t.string "{:null=>false}"
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "filled_surveys"
  add_foreign_key "answers", "questions"
  add_foreign_key "contributions", "users"
  add_foreign_key "cycles", "users"
  add_foreign_key "dispensaries", "users", column: "manager_id"
  add_foreign_key "filled_surveys", "surveys"
  add_foreign_key "filled_surveys", "users"
  add_foreign_key "materials", "material_types"
  add_foreign_key "materials", "users", column: "owner_id"
  add_foreign_key "order_materials", "materials"
  add_foreign_key "order_materials", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "profiles", "users", column: "doctor_id"
  add_foreign_key "question_options", "questions"
  add_foreign_key "questions", "question_types"
  add_foreign_key "questions", "surveys"
  add_foreign_key "slots", "users"
  add_foreign_key "studies", "users"
  add_foreign_key "study_participations", "studies"
  add_foreign_key "study_participations", "users"
  add_foreign_key "surveys", "studies"
  add_foreign_key "surveys", "users"
  add_foreign_key "transfers", "materials", column: "receiver_material_id"
  add_foreign_key "transfers", "materials", column: "sender_material_id"
  add_foreign_key "transfers", "users", column: "receiver_id"
  add_foreign_key "transfers", "users", column: "sender_id"
end
