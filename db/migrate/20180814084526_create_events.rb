class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :headline
      t.text :body
      t.date :starting_date
      t.date :ending_date
      t.integer :position
      t.boolean :on_prod

      t.timestamps
    end
  end
end
