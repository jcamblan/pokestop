class CreateJoinTableResearchStepItems < ActiveRecord::Migration[5.2]
  def change
    create_join_table :research_steps, :items do |t|
      t.index [:research_step_id, :item_id]
      t.index [:item_id, :research_step_id]
    end
  end
end
