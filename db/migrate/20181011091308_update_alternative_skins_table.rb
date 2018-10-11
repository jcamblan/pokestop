class UpdateAlternativeSkinsTable < ActiveRecord::Migration[5.2]
  def change

    add_column :alternative_skins, :shiny, :boolean
    add_column :pokemons, :alolan_form_id, :integer
    remove_column :alternative_skins, :alternative_skin_category_id
    add_column :alternative_skins, :desc, :text
    add_column :alternative_skins, :name_en, :string
    drop_table :alternative_skin_categories
  end
end
