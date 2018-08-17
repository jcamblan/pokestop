class AddTitleToEvolutionTable < ActiveRecord::Migration[5.2]
  def change
    add_column :evolutions, :title, :string
  end
end
