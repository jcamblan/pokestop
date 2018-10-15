class AddSlugToSpecialResearches < ActiveRecord::Migration[5.2]
  def change
    add_column :special_researches, :slug, :string
  end
end
