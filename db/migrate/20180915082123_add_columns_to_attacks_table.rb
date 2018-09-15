class AddColumnsToAttacksTable < ActiveRecord::Migration[5.2]
  def change
    add_column :attacks, :power, :decimal
    add_column :attacks, :epu, :decimal
    add_column :attacks, :cast_time, :decimal
    add_column :attacks, :energy_bars, :int
    rename_column :attacks, :type, :type_id
  end
end
