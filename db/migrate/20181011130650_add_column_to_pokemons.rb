class AddColumnToPokemons < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemons, :alolan, :boolean
  end
end
