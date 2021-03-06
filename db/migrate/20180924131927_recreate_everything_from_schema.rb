class RecreateEverythingFromSchema < ActiveRecord::Migration[5.2]
  def change
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
  
    create_table "alternative_skin_categories", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "alternative_skins", force: :cascade do |t|
      t.string "name"
      t.bigint "pokemon_id"
      t.bigint "alternative_skin_category_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["alternative_skin_category_id"], name: "index_alternative_skins_on_alternative_skin_category_id"
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
    end
  
    create_table "eggs_pokemons", id: false, force: :cascade do |t|
      t.integer "egg_id"
      t.integer "pokemon_id"
    end
  
    create_table "events", force: :cascade do |t|
      t.string "title"
      t.text "headline"
      t.text "body"
      t.date "start_date"
      t.date "end_date"
      t.boolean "on_prod"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
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
  
    create_table "generations", force: :cascade do |t|
      t.string "name"
      t.boolean "on_prod"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
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
    end
  
    create_table "pokemons_types", id: false, force: :cascade do |t|
      t.bigint "pokemon_id"
      t.bigint "type_id"
      t.index ["pokemon_id"], name: "index_pokemons_types_on_pokemon_id"
      t.index ["type_id"], name: "index_pokemons_types_on_type_id"
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
    end
  
    create_table "users", force: :cascade do |t|
      t.string "name"
      t.string "email"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "password_digest"
      t.string "remember_digest"
      t.index ["email"], name: "index_users_on_email", unique: true
    end
  
    add_foreign_key "alternative_skins", "alternative_skin_categories"
    add_foreign_key "alternative_skins", "pokemons"
    add_foreign_key "evolutions", "items"
    add_foreign_key "evolutions", "pokemons"
    add_foreign_key "items", "item_categories"
    add_foreign_key "pokemons", "generations"
  end
end
