class AddNameColumnsToReasearchsTables < ActiveRecord::Migration[5.2]
  def change
    add_column :research_steps, :name, :string
    add_column :research_rewards, :name, :string
    add_column :research_tasks, :name, :string
  end
end
