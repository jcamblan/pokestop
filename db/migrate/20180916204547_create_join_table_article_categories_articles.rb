class CreateJoinTableArticleCategoriesArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories_articles, id: false do |t|
      t.integer :article_category_id
      t.integer :article_id
    end
  end
end
