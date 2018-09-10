class Pokemon < ApplicationRecord
  include Fae::BaseModelConcern

  acts_as_list add_new_at: :top
  default_scope { order(:position) }

  def fae_display_field
    name
  end

  def can_evolve?
  	if Evolution.where(pokemon_id: id).first
  	  return true
  	end
  end

  def is_evolution?
  	if Evolution.where(after_evolution: id).first
  	  return true
  	end
  end

  belongs_to :generation
  has_and_belongs_to_many :types
  has_many :evolutions
end
