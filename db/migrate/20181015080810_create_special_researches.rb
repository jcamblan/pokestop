class CreateSpecialResearches < ActiveRecord::Migration[5.2]
  def change
    create_table :special_researches do |t|
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
