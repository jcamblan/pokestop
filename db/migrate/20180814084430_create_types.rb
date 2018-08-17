class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.string :name
      t.string :class_css
      t.integer :position

      t.timestamps
    end
  end
end
