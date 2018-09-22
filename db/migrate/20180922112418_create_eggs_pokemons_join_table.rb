class CreateEggsPokemonsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :eggs_pokemons, id: false do |t|
      t.integer :egg_id
      t.integer :pokemon_id
    end
  end
end
