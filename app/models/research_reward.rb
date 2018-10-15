class ResearchReward < ApplicationRecord
  belongs_to :research_step
  belongs_to :pokemon, required: false
  belongs_to :item, required: false
  belongs_to :candy, required: false


  def reward
    reward = nil
    case reward_type
    when 'pokemon'
      reward = Pokemon.find(pokemon_id)
    when 'item'
      reward = Item.find(item_id)
    when 'candy'
      reward = Candy.find(candy_id)
    end
    return reward
  end
end
