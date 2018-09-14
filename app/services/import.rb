class Import

  @backup_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', 'export.json'))))

  @@generations = @backup_file.dig('generations')
  @@candies = @backup_file.dig('candies')
  @@types = @backup_file.dig('types')
  @@items_categories = @backup_file.dig('items_categories')
  @@items = @backup_file.dig('items')
  @@pokemons = @backup_file.dig('pokemons')
  @@evolutions = @backup_file.dig('evolutions')


  def import_everything
    create_generation
    create_candies
    create_types
    create_items_categories
    create_items
    create_pokemons
    create_evolutions
  end 

## ON IMPORTE TOUJOURS LES GENERATIONS EN PREMIER

  def create_generations
  	@@generations.each do |generation|
      create_generation(generation)
  	end
  end

  def create_generation(generation)
    Generation.create(name: generation['name'])
  end

## PUIS LES BONBONS

  def create_candies
  	@@candies.each do |candy|
      get_candy(candy)
  	end
  end

  def get_candy(candy)
    Candy.create(name: candy['name'], primary_color: candy['primary_color'], secondary_color: candy['secondary_color'])
  end

## PUIS LES TYPES DE POKEMONS

  def create_types
  	@@types.each do |type|
      create_type(type)
  	end
  end

  def create_type(type)
    Type.create(name: type['name'])
  end

## PUIS LES CATEGORIES D'OBJETS

  def create_items_categories
  	@@items_categories.each do |item_category|
      create_item_category(item_category)
  	end
  end

  def create_item_category(item_category)
    ItemCategory.create(name: item_category['name'])
  end

## PUIS LES OBJETS

  def create_items
  	@@items.each do |item|
      create_item(item)
  	end
  end

  def create_item(item)
    Item.create(
      name: item['name'],
      desc: item['description'],
      category_id: Category.where(name: item['category']).first.id)
  end

## PUIS LES POKEMONS

  def create_pokemons
  	@@pokemons.each do |pokemon|
      create_pokemon(pokemon)
  	end
  end

  def create_pokemon(pokemon)
    p = Pokemon.new
    p.name = pokemon['name']
    p.num = pokemon['num']
    p.candy_id = Candy.where(name: pokemon['candy']).first.id if pokemon['candy']
    p.candy_distance = pokemon['candy_distance']
    p.pc_max = pokemon['pc_max']
    p.pv_max = pokemon['pv_max']
    p.generation_id = pokemon['generation']
    p.pokedex_entry = pokemon['pokedex_entry']
    p.comment = pokemon['comment']
    p.types << Type.where(name: pokemon['type_1']).or(Type.where(name: pokemon['type_2'])
    p.save
  end

## PUIS LES EVOLUTIONS

  def create_evolutions
  	@@evolutions.each do |evolution|
      create_evolution(evolution)
  	end
  end

  def create_evolution(evolution)
    e = Evolution.new
    e.title = evolution['title']
    e.first_form = Pokemon.where(name: evolution['first_form']).first.id
    e.pokemon_id = Pokemon.where(name: evolution['before_evolution']).first.id
    e.after_evolution = Pokemon.where(name: evolution['after_evolution']).first.id
    e.candies: evolution['candies']
    e.item = Item.where(name: evolution['item']).first.id if evolution['item']
    e.save
  end



end