class AddColumnToResearchReward < ActiveRecord::Migration[5.2]
  def change
    add_column :research_rewards, :reward_type, :string
  end
end
