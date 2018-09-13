class CreateCandies < ActiveRecord::Migration[5.2]
  def change
    create_table :candies do |t|
      t.string :name
      t.string :primary_color
      t.string :secondary_color

      t.timestamps
    end
  end
end
