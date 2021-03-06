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

ActiveRecord::Schema.define(version: 2018_10_24_075337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "alternative_skins", force: :cascade do |t|
    t.string "name"
    t.bigint "pokemon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "shiny"
    t.text "desc"
    t.string "name_en"
    t.string "nametag"
    t.index ["pokemon_id"], name: "index_alternative_skins_on_pokemon_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "header"
    t.text "body"
    t.boolean "published"
    t.boolean "homepage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "image_id"
    t.string "slug"
  end

  create_table "articles_tags", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "article_id"
  end

  create_table "attack_categories", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attacks", force: :cascade do |t|
    t.string "name"
    t.integer "type_id"
    t.string "attack_category_id"
    t.string "name_en"
    t.decimal "power"
    t.decimal "epu"
    t.decimal "cast_time"
    t.integer "energy_bars"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "attacks_pokemons", id: false, force: :cascade do |t|
    t.integer "attack_id"
    t.integer "pokemon_id"
  end

  create_table "candies", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.string "primary_color"
    t.string "secondary_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "eggs", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "eggs_pokemons", id: false, force: :cascade do |t|
    t.integer "egg_id"
    t.integer "pokemon_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "headline"
    t.text "body"
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "on_prod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "image_url"
  end

  create_table "evolutions", force: :cascade do |t|
    t.string "title"
    t.string "title_en"
    t.integer "first_form"
    t.bigint "pokemon_id"
    t.integer "after_evolution"
    t.integer "candies"
    t.bigint "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extreme_weaknesses_types", id: false, force: :cascade do |t|
    t.integer "type_id"
    t.integer "extreme_weakness_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "generations", force: :cascade do |t|
    t.string "name"
    t.boolean "on_prod"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "images", force: :cascade do |t|
    t.text "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_categories", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.text "desc"
    t.bigint "item_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "movesets", force: :cascade do |t|
    t.integer "pokemon_id"
    t.integer "fast_attack_id"
    t.integer "charge_attack_id"
    t.decimal "raw_attacking_dps"
    t.decimal "raw_defending_dps"
    t.decimal "fast_attack_raw_dps"
    t.decimal "charge_attack_raw_dps"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "num"
    t.bigint "generation_id"
    t.string "name"
    t.string "name_en"
    t.integer "candy_id"
    t.integer "candy_distance"
    t.integer "pc_max"
    t.text "pokedex_entry"
    t.text "comment"
    t.integer "atk"
    t.integer "def"
    t.integer "sta"
    t.decimal "flee_rate"
    t.decimal "capture_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "alolan_form_id"
    t.boolean "alolan"
    t.string "slug"
  end

  create_table "pokemons_types", id: false, force: :cascade do |t|
    t.bigint "pokemon_id"
    t.bigint "type_id"
    t.index ["pokemon_id"], name: "index_pokemons_types_on_pokemon_id"
    t.index ["type_id"], name: "index_pokemons_types_on_type_id"
  end

  create_table "research_rewards", force: :cascade do |t|
    t.bigint "research_step_id"
    t.integer "quantity"
    t.bigint "pokemon_id"
    t.bigint "item_id"
    t.bigint "candy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reward_type"
    t.string "name"
    t.index ["candy_id"], name: "index_research_rewards_on_candy_id"
    t.index ["item_id"], name: "index_research_rewards_on_item_id"
    t.index ["pokemon_id"], name: "index_research_rewards_on_pokemon_id"
    t.index ["research_step_id"], name: "index_research_rewards_on_research_step_id"
  end

  create_table "research_steps", force: :cascade do |t|
    t.integer "step_id"
    t.bigint "special_research_id"
    t.bigint "candy_id"
    t.bigint "pokemon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["candy_id"], name: "index_research_steps_on_candy_id"
    t.index ["pokemon_id"], name: "index_research_steps_on_pokemon_id"
    t.index ["special_research_id"], name: "index_research_steps_on_special_research_id"
  end

  create_table "research_tasks", force: :cascade do |t|
    t.bigint "research_step_id"
    t.string "desc"
    t.string "desc_en"
    t.integer "xp_reward"
    t.bigint "pokemon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "pokemon_reward"
    t.integer "item_reward"
    t.string "reward_type"
    t.index ["pokemon_id"], name: "index_research_tasks_on_pokemon_id"
    t.index ["research_step_id"], name: "index_research_tasks_on_research_step_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "special_researches", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.text "desc"
  end

  create_table "strengths_types", id: false, force: :cascade do |t|
    t.integer "type_id"
    t.integer "strength_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.string "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "types_weaknesses", id: false, force: :cascade do |t|
    t.integer "type_id"
    t.integer "weakness_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "alternative_skins", "pokemons"
  add_foreign_key "evolutions", "items"
  add_foreign_key "evolutions", "pokemons"
  add_foreign_key "items", "item_categories"
  add_foreign_key "pokemons", "generations"
  add_foreign_key "research_rewards", "candies"
  add_foreign_key "research_rewards", "items"
  add_foreign_key "research_rewards", "pokemons"
  add_foreign_key "research_rewards", "research_steps"
  add_foreign_key "research_steps", "candies"
  add_foreign_key "research_steps", "pokemons"
  add_foreign_key "research_steps", "special_researches"
  add_foreign_key "research_tasks", "pokemons"
  add_foreign_key "research_tasks", "research_steps"
end
