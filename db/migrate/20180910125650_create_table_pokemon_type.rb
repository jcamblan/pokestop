class CreateTablePokemonType < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons_types, id: false do |t|
      t.belongs_to :pokemon, index: true
      t.belongs_to :type, index: true
    end
  end
end