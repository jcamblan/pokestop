class CreateAttackCategory < ActiveRecord::Migration[5.2]
  def change
    create_table :attack_categories do |t|
      t.string :name
      t.string :name_en
    end
    rename_column :attacks, :attack_category, :attack_category_id
  end
end
