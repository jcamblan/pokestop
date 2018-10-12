class AddSlugColumns < ActiveRecord::Migration[5.2]
  def change
   add_column :articles, :slug, :string
   add_column :pokemons, :slug, :string
   add_column :generations, :slug, :string
   add_column :attacks, :slug, :string
   add_column :eggs, :slug, :string
   add_column :items, :slug, :string
   add_column :events, :slug, :string
   add_column :types, :slug, :string
  end
end
