class CreateAlternativeSkins < ActiveRecord::Migration[5.2]
  def change
    create_table :alternative_skins do |t|
      t.string :name
      t.references :pokemon, foreign_key: true
      t.references :alternative_skin_category, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
