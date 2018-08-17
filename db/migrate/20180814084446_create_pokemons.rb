class CreatePokemons < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :num
      t.integer :type_1
      t.integer :type_2
      t.string :candy
      t.integer :candy_distance
      t.integer :pc_min
      t.integer :pc_max
      t.integer :pv_min
      t.integer :pv_max
      t.references :generation, foreign_key: true
      t.text :pokedex_entry
      t.text :comment
      t.integer :position

      t.timestamps
    end
  end
end
