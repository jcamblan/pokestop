class AddColumnsToMovesets < ActiveRecord::Migration[5.2]
  def change
    add_column :movesets, :fast_attack_raw_dps, :decimal
    add_column :movesets, :charge_attack_raw_dps, :decimal
  end
end
