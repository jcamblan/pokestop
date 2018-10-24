class AddColumnToResearchTasksAgain < ActiveRecord::Migration[5.2]
  def change
    add_column :research_tasks, :reward_type, :string
  end
end
