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
    if can_evolve? || is_evolution?
      first_form_id = Evolution.where(pokemon_id: id).or(Evolution.where(after_evolution: id)).first.first_form
      pokemon = Pokemon.where(id: first_form_id) #le where à la place du find est voulu pour pouvoir lancer un .each dans le partial _evolution
      return pokemon
    end
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

  def candy
    Candy.find(candy_id) if candy_id
  end

  def max_atk
    Pokemon.where("atk > 0").order(:atk).last.atk
  end

  def max_def
    Pokemon.where("def > 0").order(:def).last.def
  end

  def max_sta
    Pokemon.where("sta > 0").order(:sta).last.sta
  end

  def charge_attacks
    self.attacks.where(attack_category_id: 2)
  end
  
  def fast_attacks
    self.attacks.where(attack_category_id: 1)
  end

  belongs_to :generation
  has_and_belongs_to_many :types
  has_and_belongs_to_many :attacks
  has_many :evolutions
  #belongs_to :candy
end
