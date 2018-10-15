class ResearchTask < ApplicationRecord
  belongs_to :research_step
  belongs_to :pokemon, required: false
end
