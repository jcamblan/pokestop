class CreateAttacks < ActiveRecord::Migration[5.2]
  def change
    create_table :attacks do |t|
      t.string :name
      t.integer :type
      t.string :attack_category
      t.integer :position

      t.timestamps
    end
  end
end
