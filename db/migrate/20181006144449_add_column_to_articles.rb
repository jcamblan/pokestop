class AddColumnToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :image_id, :integer
  end
end
