class CreateResearchRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :research_rewards do |t|
      t.references :research_step, foreign_key: true
      t.integer :quantity
      t.references :pokemon, foreign_key: true
      t.references :item, foreign_key: true
      t.references :candy, foreign_key: true

      t.timestamps
    end
    drop_table :items_research_steps
  end
end
