class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :desc
      t.integer :position
      t.references :item_category, foreign_key: true

      t.timestamps
    end
  end
end
