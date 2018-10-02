class RenameColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :articles_tags, :article_category_id, :tag_id
  end
end
