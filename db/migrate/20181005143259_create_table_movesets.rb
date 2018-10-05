class CreateTableMovesets < ActiveRecord::Migration[5.2]
  def change
    create_table :movesets do |t|
      t.integer :pokemon_id
      t.integer :fast_attack_id
      t.integer :charge_attack_id
      t.decimal :raw_attacking_dps
      t.decimal :raw_defending_dps
    end
  end
end
