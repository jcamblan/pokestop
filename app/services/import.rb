class Import

  @backup_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', 'export.json'))))

  @@generations = @backup_file.dig('generations')
  @@candies = @backup_file.dig('candies')
  @@types = @backup_file.dig('types')
  @@attack_categories = @backup_file.dig('attack_categories')
  @@attacks = @backup_file.dig('attacks')
  @@item_categories = @backup_file.dig('item_categories')
  @@items = @backup_file.dig('items')
  @@pokemons = @backup_file.dig('pokemons')
  @@evolutions = @backup_file.dig('evolutions')

  def import_everything
    create_generations if @@generations
    create_candies if @@candies
    create_types if @@types
    create_attack_categories if @@attack_categories
    create_attacks if @@attacks
    create_item_categories if @@item_categories
    create_items if @@items
    create_pokemons if @@pokemons
    create_evolutions if @@evolutions
  end 

## ON IMPORTE TOUJOURS LES GENERATIONS EN PREMIER

  def create_generations
    @@generations.each do |generation|
      create_generation(generation) unless Generation.where(name: generation['name']).first
    end
  end

  def create_generation(generation)
    Generation.create(name: generation['name'])
  end

## PUIS LES BONBONS

  def create_candies
    @@candies.each do |candy|
      get_candy(candy) unless Candy.where(name: candy['name']).first
    end
  end

  def get_candy(candy)
    Candy.create(name: candy['name'], name_en: candy['name_en'], primary_color: candy['primary_color'], secondary_color: candy['secondary_color'])
  end

## PUIS LES TYPES DE POKEMONS

  def create_types
    @@types.each do |type|
      create_type(type) unless Type.where(name: type['name']).first
    end
  end

  def create_type(type)
    Type.create(name: type['name'], name_en: type['name_en'])
  end

## PUIS LES CATEGORIES D'ATTAQUES

  def create_attack_categories
    @@attack_categories.each do |attack_category|
      create_attack_category(attack_category) unless AttackCategory.where(name: attack_category['name']).first
    end
  end

  def create_attack_category(attack_category)
    AttackCategory.create(name: attack_category['name'], name_en: attack_category['name_en'])
  end

## PUIS LES ATTAQUES

  def create_attacks
    @@attacks.each do |attack|
      create_attack(attack) unless Attack.where(name: attack['name']).first
    end
  end

  def create_attack(attack)
    a = Attack.new
    a.name = attack['name']
    a.name_en = attack['name_en']
    a.power = attack['power']
    a.cast_time = attack['cast_time']
    a.epu = attack['epu'] if attack['epu']
    a.energy_bars = attack['energy_bars'] if attack['energy_bars']
    a.attack_category_id = AttackCategory.where(name: attack['attack_category']).first.id
    a.save
  end

## PUIS LES CATEGORIES D'OBJETS

  def create_item_categories
    @@item_categories.each do |item_category|
      create_item_category(item_category) unless ItemCategory.where(name: item_category['name']).first
    end
  end

  def create_item_category(item_category)
    ItemCategory.create(name: item_category['name'], name_en: item_category['name_en'])
  end

## PUIS LES OBJETS

  def create_items
    @@items.each do |item|
      create_item(item) unless Item.where(name: item['name']).first
    end
  end

  def create_item(item)
    Item.create(
      name: item['name'],
      name_en: item['name_en'],
      desc: item['description'],
      item_category_id: ItemCategory.where(name: item['category']).first.id)
  end

## PUIS LES POKEMONS

  def create_pokemons
    @@pokemons.each do |pokemon|
      create_pokemon(pokemon) unless Pokemon.where(name: pokemon['name']).first
    end
  end

  def create_pokemon(pokemon)
    p = Pokemon.new
    p.name = pokemon['name']
    p.name_en = pokemon['name_en']
    p.num = pokemon['num']
    p.candy_id = Candy.where(name: pokemon['candy']).first.id if pokemon['candy']
    p.candy_distance = pokemon['candy_distance']
    p.pc_max = pokemon['pc_max']
    p.pv_max = pokemon['pv_max']
    p.atk = pokemon['atk']
    p.def = pokemon['def']
    p.sta = pokemon['sta']
    p.flee_rate = pokemon['flee_rate']
    p.capture_rate = pokemon['capture_rate']
    p.generation_id = pokemon['generation']
    p.pokedex_entry = pokemon['pokedex_entry']
    p.comment = pokemon['comment']
    p.types << Type.where(name: pokemon['type_1']).or(Type.where(name: pokemon['type_2']))
    p.attacks << pokemon_attacks_list(pokemon['attacks'])
    p.save
  end

  def pokemon_attacks_list(attacks)
    attacks_array = Array.new
    attacks.each do |a|
      attacks_array << Attack.where(name_en: a['name_en']).first
    end
    return attacks_array
  end

## PUIS LES EVOLUTIONS

  def create_evolutions
    @@evolutions.each do |evolution|
      create_evolution(evolution) unless Evolution.where(title: evolution['title']).first
    end
  end

  def create_evolution(evolution)
    e = Evolution.new
    e.title = evolution['title']
    e.title_en = evolution['title_en']
    e.first_form = Pokemon.where(num: evolution['first_form']).first.id
    e.pokemon_id = Pokemon.where(num: evolution['before_evolution']).first.id
    e.after_evolution = Pokemon.where(num: evolution['after_evolution']).first.id
    e.candies = evolution['candies']
    e.item_id = Item.where(name: evolution['item']).first.id if evolution['item']
    e.save
  end

end