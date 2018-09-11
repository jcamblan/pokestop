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

  def first_form
    first_form_id = Evolution.where(pokemon_id: id).or(Evolution.where(after_evolution: id)).first.first_form
    pokemon = Pokemon.where(id: first_form_id)
    return pokemon
  end

  def evolutions_as_pokemons
    evolutions = Evolution.where(pokemon_id: id)
    evolutions_array = Array.new
    evolutions.each do |e|
      evolutions_array << Pokemon.find(e.after_evolution)
    end
    return evolutions_array
  end

  belongs_to :generation
  has_and_belongs_to_many :types
  has_many :evolutions
end
