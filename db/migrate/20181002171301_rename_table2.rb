class RenameTable2 < ActiveRecord::Migration[5.2]
  def change
    rename_table :article_categories_articles, :articles_tags
  end
end
