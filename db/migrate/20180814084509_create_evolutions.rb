class CreateEvolutions < ActiveRecord::Migration[5.2]
  def change
    create_table :evolutions do |t|
      t.integer :first_form
      t.references :pokemon, foreign_key: true
      t.integer :after_evolution
      t.integer :candies
      t.references :item, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
