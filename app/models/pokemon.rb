class Pokemon < ApplicationRecord
  include Fae::BaseModelConcern

  #acts_as_list add_new_at: :top
  #default_scope { order(:position) }

  def fae_display_field
    name
  end

  def can_evolve?
  	Evolution.where(pokemon_id: id).exists?
  end

  def is_evolution?
  	Evolution.where(after_evolution: id).exists?
  end

  def first_form
    first_form_id = Evolution.where(pokemon_id: id).or(Evolution.where(after_evolution: id)).first.first_form
    pokemon = Pokemon.where(id: first_form_id)
    return pokemon
  end

  def evolutions_as_pokemons
    evolutions = Evolution.where(pokemon_id: id).order(:pokemon_id)
    evolutions_array = Array.new
    evolutions.each do |e|
      evolutions_array << Pokemon.find(e.after_evolution)
    end
    return evolutions_array
  end

  def prev
    Pokemon.where("id < ?", id).order("id DESC").first || Pokemon.last
  end
  
  def next
    Pokemon.where("id > ?", id).order("id ASC").first || Pokemon.first
  end

  belongs_to :generation
  has_and_belongs_to_many :types
  has_many :evolutions
end
