class AddColumnsToPokemons < ActiveRecord::Migration[5.2]
  def change
    add_column :pokemons, :atk, :integer
    add_column :pokemons, :def, :integer
    add_column :pokemons, :sta, :integer
    add_column :pokemons, :flee_rate, :decimal
    add_column :pokemons, :capture_rate, :decimal
  end
end
