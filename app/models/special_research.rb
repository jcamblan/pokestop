class SpecialResearch < ApplicationRecord
  has_many :research_steps

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def should_generate_new_friendly_id?
    name_changed?
  end

  def total_xp
    xp = 0
    self.research_steps.each do |step|
      step.research_tasks.each do |task|
        if task.reward_type == "xp"
          xp += task.xp_reward
        end
      end
    end
    return xp
  end

  def pokemons_rewarded
    pokemons = Array.new
    self.research_steps.each do |step|
      step.research_rewards.each do |reward|
        if reward.reward_type == 'pokemon'
          pokemons << reward.pokemon
        end
      end
      step.research_tasks.each do |task|
        if task.reward_type == 'pokemon'
          pokemons << task.reward
        end
      end
    end
    return pokemons
  end

  def items_rewarded
    items = Array.new
    self.research_steps.each do |step|
      step.research_rewards.each do |reward|
        if reward.reward_type == 'item'
          items << reward.item
        end
      end
    end
    return items
  end

end
