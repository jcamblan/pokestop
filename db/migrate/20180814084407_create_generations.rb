class CreateGenerations < ActiveRecord::Migration[5.2]
  def change
    create_table :generations do |t|
      t.string :name
      t.boolean :on_prod
      t.integer :position

      t.timestamps
    end
  end
end
