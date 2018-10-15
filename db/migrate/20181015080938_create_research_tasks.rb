class CreateResearchTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :research_tasks do |t|
      t.references :research_step, foreign_key: true
      t.string :desc
      t.string :desc_en
      t.integer :xp_reward
      t.references :pokemon, foreign_key: true

      t.timestamps
    end
  end
end
