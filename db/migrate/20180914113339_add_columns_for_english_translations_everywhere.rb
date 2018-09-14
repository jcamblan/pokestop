class AddColumnsForEnglishTranslationsEverywhere < ActiveRecord::Migration[5.2]
  def change
    add_column :attacks, :name_en, :string
    add_column :candies, :name_en, :string
    add_column :evolutions, :title_en, :string
    add_column :item_categories, :name_en, :string
    add_column :items, :name_en, :string
    add_column :pokemons, :name_en, :string
    add_column :types, :name_en, :string
  end
end
