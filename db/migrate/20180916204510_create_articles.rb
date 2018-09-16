class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :header
      t.text :body
      t.integer :position
      t.boolean :published
      t.boolean :homepage

      t.timestamps
    end
  end
end
