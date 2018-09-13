class FixCandyColumnTypeInPokemonTable < ActiveRecord::Migration[5.2]
  def change
  	change_column :pokemons, :candy_id, :integer
  end
end
