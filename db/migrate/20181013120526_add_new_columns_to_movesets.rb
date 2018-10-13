class AddNewColumnsToMovesets < ActiveRecord::Migration[5.2]
  def change
    add_column :movesets, :created_at, :datetime
    add_column :movesets, :updated_at, :datetime
  end
end
