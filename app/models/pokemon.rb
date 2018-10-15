class Pokemon < ApplicationRecord
  belongs_to :generation, touch: true
  has_and_belongs_to_many :types, touch: true
  has_and_belongs_to_many :attacks, touch: true
  has_many :evolutions
  has_and_belongs_to_many :eggs, touch: true
  belongs_to :candy, required: false
  has_many :movesets
  has_many :alternative_skins

  validates :name, presence: true
  validates :num, presence: true
  validates :pc_max, numericality: { only_integer: true }, :allow_nil => true
  validates :atk, numericality: { only_integer: true }, :allow_nil => true
  validates :def, numericality: { only_integer: true }, :allow_nil => true
  validates :sta, numericality: { only_integer: true }, :allow_nil => true
  validates :candy_distance, numericality: { only_integer: true }, :allow_nil => true
  validates :flee_rate, numericality: true, :allow_nil => true
  validates :capture_rate, numericality: true, :allow_nil => true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]


  def image_path
    return "pokemon/#{self.generation.id}-#{self.generation.name.parameterize}/#{self.num}.png"
  end

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
    Pokemon.where("num < ?", num).order("num DESC").first || Pokemon.order("num DESC").first
  end
  
  def next
    Pokemon.where("num > ?", num).order("num ASC").first || Pokemon.first
  end

  #------------------------------------------------------------------------
  # Gestion des pokémons aloha
  #------------------------------------------------------------------------

  def alolan_form
    Pokemon.find(alolan_form_id) if alolan_form_id
  end

  def original_form
    Pokemon.find_by(alolan_form_id: id) if alolan
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
    self.attacks.where(attack_category_id: AttackCategory.find_by(name_en: "Charge Attack").id)
  end
  
  def fast_attacks
    self.attacks.where(attack_category_id: AttackCategory.find_by(name_en: "Fast Attack").id)
  end

  #------------------------------------------------------------------------
  # Ces méthodes permettent de récupérer les types + ou - efficaces contre le pokémon
  #------------------------------------------------------------------------

  # Ici, on vérifie si le pokémon possède plus d'un type (donc deux). Si oui, on va récupérer les
  # types qui contrent à la fois les deux
  def types_very_strong_against_it
    if self.types.count > 1
      return get_very_strong_types_array(self.types.first.weak_against,self.types.last.weak_against)
    end
  end

  # On crée le tableau contenant les types forts contre les deux types du pokémon
  def get_very_strong_types_array(type1_weaknesses,type2_weaknesses)
    array = Array.new
    dangerous_types_list = type1_weaknesses + type2_weaknesses
    dangerous_types_list.uniq.each do |type|
      if type1_weaknesses.include?(type) && type2_weaknesses.include?(type)
        array << type
      end
    end
    return array unless array.empty?
  end

  # Si le pokémon n'a qu'un seul type, on récupère facilement les types forts contre celui-ci
  # S'il en a deux, on appelle la génération d'un tableau listant les types fort contre
  # l'un ou l'autre de ses deux types (mais pas contre les deux)
  def types_strong_against_it
    if self.types.count == 1
      return self.types.first.weak_against
    else
      return get_strong_types_array(self.types.first.weak_against,self.types.last.weak_against)
    end
  end

  # On crée le tableau contenant les types fort contre l'un ou l'autre des types du pokémon
  def get_strong_types_array(type1_weaknesses,type2_weaknesses)
    array = Array.new
    dangerous_types_list = type1_weaknesses + type2_weaknesses
    dangerous_types_list.uniq.each do |type|
      unless type1_weaknesses.include?(type) && type2_weaknesses.include?(type)
        unless get_weak_types_array.include?(type)
          array << type
        end
      end
    end
    return array unless array.empty?
  end

  # On génère un tableau listant les types faibles ou très faibles contre les types du pokémon
  # de manière à les soustraire au tableau généré par get_strong_types_array
  def get_weak_types_array
    array = Array.new
    self.types.each do |type|
      array << type.tough_against
      array << type.very_tough_against
    end
    return array.uniq
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
      :with_type_id,
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
    where(:generation_id => [*generation_ids]).order(:num)
  }

  scope :with_type_id, lambda { |type_id|
    where(:id => Type.find(type_id).pokemons.ids).order(:num)
  }

  scope :with_on_prod, lambda { |check|
    return nil if 0 == check # checkbox unchecked
    where(:generation_id => Generation.where(on_prod: true).ids).order(:num)
  }

end
