class FixCandyColumnNameInPokemonTable < ActiveRecord::Migration[5.2]
  def change
  	rename_column :pokemons, :candy, :candy_id
  end
end
