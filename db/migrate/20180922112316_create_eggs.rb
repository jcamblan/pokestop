class CreateEggs < ActiveRecord::Migration[5.2]
  def change
    create_table :eggs do |t|
      t.string :name
      t.text :desc
      t.integer :position

      t.timestamps
    end
  end
end
