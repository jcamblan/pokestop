class Pokemon < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :generation
  has_and_belongs_to_many :types
  has_and_belongs_to_many :attacks
  has_many :evolutions

  #------------------------------------------------------------------------
  # On vérifie si le pokémon peut évoluer ou s'il est lui-même l'évolution d'un autre pokémon
  #------------------------------------------------------------------------

  def can_evolve?
  	Evolution.where(pokemon_id: id).exists?
  end

  def is_evolution?
  	Evolution.where(after_evolution: id).exists?
  end

  #------------------------------------------------------------------------
  # On récupère le pokémon le plus ancien dans l'arbre généalogique d'un pokémon
  #------------------------------------------------------------------------

  def first_form
    if can_evolve? || is_evolution?
      first_form_id = Evolution.where(pokemon_id: id).or(Evolution.where(after_evolution: id)).first.first_form
      pokemon = Pokemon.where(id: first_form_id) #le where à la place du find est voulu pour pouvoir lancer un .each dans le partial _evolution
      return pokemon
    end
  end

  #------------------------------------------------------------------------
  # On récupère la liste des évolutions d'un pokémon
  # puis on retourne les pokémons résultant de celles-ci
  #------------------------------------------------------------------------

  def evolutions_as_pokemons
    evolutions = Evolution.where(pokemon_id: id).order(:pokemon_id)
    evolutions_array = Array.new
    evolutions.each do |e|
      evolutions_array << Pokemon.find(e.after_evolution)
    end
    return evolutions_array
  end

  #------------------------------------------------------------------------
  # Raccourcis rapides vers les pokemons suivant et précédant un pokemon donné
  #------------------------------------------------------------------------

  def prev
    Pokemon.where("num < ?", num).order("num DESC").first || Pokemon.last
  end
  
  def next
    Pokemon.where("num > ?", num).order("num ASC").first || Pokemon.first
  end

  #------------------------------------------------------------------------
  # Récupération du bonbon associé au pokémon
  #------------------------------------------------------------------------

  def candy
    Candy.find(candy_id) if candy_id
  end

  #------------------------------------------------------------------------
  # Les valeurs max des stats servent à générer les barres de progression
  #------------------------------------------------------------------------

  def max_pc_max
    Pokemon.where("pc_max > 0").order(:pc_max).last.pc_max
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

  #------------------------------------------------------------------------
  # On récupère la liste des attaques d'une catégorie précise d'un pokemon
  #------------------------------------------------------------------------

  def charge_attacks
    self.attacks.where(attack_category_id: 1)
  end
  
  def fast_attacks
    self.attacks.where(attack_category_id: 2)
  end

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

  #------------------------------------------------------------------------
  # Définition des filtres et des critères de tri pour la gem filterrific
  #------------------------------------------------------------------------

  filterrific(
    default_filter_params: { sorted_by: 'num_asc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_generation_id,
      :with_on_prod
    ]
  )

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^num_/
      order("pokemons.num #{ direction }")
    when /^name_/
      order("LOWER(pokemons.name) #{ direction }")
    when /^atk_/
      order("pokemons.atk #{ direction }")
    when /^def_/
      order("pokemons.def #{ direction }")
    when /^sta_/
      order("pokemons.sta #{ direction }")
    when /^pc_max_/
      order("pokemons.pc_max #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_generation_id, lambda { |generation_ids|
    where(:generation_id => [*generation_ids])
  }

  scope :with_on_prod, lambda { |select|
    where(:generation_id => Generation.where(on_prod: true).ids)
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Name (a-a)', 'name_desc'],
      ['Num', 'num_asc'],
      ['Attaque asc', 'atk_asc'],
      ['Attaque desc', 'atk_desc'],
      ['Défense asc', 'def_asc'],
      ['Défense desc', 'def_desc'],
      ['Endurance asc', 'sta_asc'],
      ['Endurance desc', 'sta_desc'],
      ['PC asc', 'pc_max_asc'],
      ['PC desc', 'pc_max_desc']
    ]
  end
end
