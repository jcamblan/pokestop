class RenameTables < ActiveRecord::Migration[5.2]
   def change
     rename_table :article_categories, :tags
     rename_table :photos, :images
   end 
end
