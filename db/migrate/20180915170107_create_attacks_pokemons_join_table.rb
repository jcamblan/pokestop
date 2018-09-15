class CreateAttacksPokemonsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :attacks_pokemons, id: false do |t|
      t.integer :attack_id
      t.integer :pokemon_id
    end
  end
end
