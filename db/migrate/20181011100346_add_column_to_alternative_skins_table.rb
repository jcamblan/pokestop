class AddColumnToAlternativeSkinsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :alternative_skins, :nametag, :string
  end
end
