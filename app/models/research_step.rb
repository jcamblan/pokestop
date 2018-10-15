class ResearchStep < ApplicationRecord
  belongs_to :special_research
  belongs_to :candy, required: false
  belongs_to :pokemon, required: false
  has_many :research_rewards
  has_many :research_tasks
end
