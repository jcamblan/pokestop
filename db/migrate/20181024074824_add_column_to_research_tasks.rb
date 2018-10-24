class AddColumnToResearchTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :research_tasks, :pokemon_reward, :integer
    add_column :research_tasks, :item_reward, :integer
    add_column :special_researches, :desc, :text
  end
end
