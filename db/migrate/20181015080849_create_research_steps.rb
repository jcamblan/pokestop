class CreateResearchSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :research_steps do |t|
      t.integer :step_id
      t.references :special_research, foreign_key: true
      t.references :candy, foreign_key: true
      t.references :pokemon, foreign_key: true

      t.timestamps
    end
  end
end
