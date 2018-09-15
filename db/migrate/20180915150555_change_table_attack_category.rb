class ChangeTableAttackCategory < ActiveRecord::Migration[5.2]
  def change
    add_column :attack_categories, :created_at, :datetime
    add_column :attack_categories, :updated_at, :datetime
  end
end
