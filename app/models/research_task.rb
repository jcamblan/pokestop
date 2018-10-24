class ResearchTask < ApplicationRecord
  belongs_to :research_step
  belongs_to :pokemon, required: false

  def reward
    reward = nil
    case reward_type
    when 'pokemon'
      reward = Pokemon.find(pokemon_reward)
    when 'item'
      reward = Item.find(item_reward)
    when 'xp'
      reward = xp_reward
    end
    return reward
  end
end
