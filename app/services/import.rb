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
  @@eggs = @backup_file.dig('eggs')
  @@evolutions = @backup_file.dig('evolutions')
  @@alternative_skins = @backup_file.dig('alternative_skins')
  @@special_researches = @backup_file.dig('special_researches')

  def import_everything
    clear_everything
    create_generations if @@generations
    create_candies if @@candies
    create_types if @@types
    give_types_strengths_and_weaknesses if @@types
    create_attack_categories if @@attack_categories
    create_attacks if @@attacks
    create_item_categories if @@item_categories
    create_items if @@items
    create_pokemons if @@pokemons
    create_eggs if @@eggs
    create_evolutions if @@evolutions
    create_alternative_skins if @@alternative_skins
    create_special_researches if @@special_researches
  end 

## ON VIDE

  def clear_everything
    ResearchTask.delete_all
    ResearchReward.delete_all
    ResearchStep.delete_all
    SpecialResearch.delete_all
    AlternativeSkin.delete_all
    Evolution.delete_all
    Pokemon.delete_all
    Egg.delete_all
    Item.delete_all
    ItemCategory.delete_all
    Attack.delete_all
    AttackCategory.delete_all
    Type.delete_all
    Candy.delete_all
    Generation.delete_all
    ActiveRecord::Base.connection.execute("DELETE FROM attacks_pokemons")
    ActiveRecord::Base.connection.execute("DELETE FROM eggs_pokemons")
    ActiveRecord::Base.connection.execute("DELETE FROM extreme_weaknesses_types")
    ActiveRecord::Base.connection.execute("DELETE FROM pokemons_types")
    ActiveRecord::Base.connection.execute("DELETE FROM strengths_types")
    ActiveRecord::Base.connection.execute("DELETE FROM types_weaknesses")
    ActiveRecord::Base.connection.reset_pk_sequence!('research_tasks')
    ActiveRecord::Base.connection.reset_pk_sequence!('research_rewards')
    ActiveRecord::Base.connection.reset_pk_sequence!('research_steps')
    ActiveRecord::Base.connection.reset_pk_sequence!('special_researches')
    ActiveRecord::Base.connection.reset_pk_sequence!('generations')
    ActiveRecord::Base.connection.reset_pk_sequence!('candies')
    ActiveRecord::Base.connection.reset_pk_sequence!('types')
    ActiveRecord::Base.connection.reset_pk_sequence!('attack_categories')
    ActiveRecord::Base.connection.reset_pk_sequence!('attacks')
    ActiveRecord::Base.connection.reset_pk_sequence!('item_categories')
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    ActiveRecord::Base.connection.reset_pk_sequence!('pokemons')
    ActiveRecord::Base.connection.reset_pk_sequence!('eggs')
    ActiveRecord::Base.connection.reset_pk_sequence!('evolutions')
    ActiveRecord::Base.connection.reset_pk_sequence!('alternative_skins')
  end

## ON IMPORTE TOUJOURS LES GENERATIONS EN PREMIER

  def create_generations
    @@generations.each do |generation|
      create_generation(generation) unless Generation.where(name: generation['name']).first
    end
  end

  def create_generation(generation)
    Generation.create(name: generation['name'], on_prod: generation['on_prod'])
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

## ASSOCIATION DES TYPES PAR FORCES/FAIBLESSES

  def give_types_strengths_and_weaknesses
    @@types.each do |type|
      give_type_strengths_and_weaknesses(type) if Type.find_by(name_en: type['name_en'])
    end
  end

  def give_type_strengths_and_weaknesses(type)
    t = Type.find_by(name_en: type['name_en'])
    t.strengths.clear
    t.strengths << type_types_list(type['strengths'])
    t.weaknesses.clear
    t.weaknesses << type_types_list(type['weaknesses'])
    t.extreme_weaknesses.clear
    t.extreme_weaknesses << type_types_list(type['extreme_weaknesses'])
    t.save
  end

  def type_types_list(types)
    types_array = Array.new
    types.each do |t|
      types_array << Type.find_by(name_en: t['name_en'])
    end
    return types_array
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
    a.type_id = Type.where(name: attack['type']).first.id if attack['type']
    a.power = attack['power'].to_f
    a.cast_time = attack['cast_time'].to_f
    a.epu = attack['epu'].to_f if attack['epu']
    a.energy_bars = attack['energy_bars'].to_i if attack['energy_bars']
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
    @@pokemons.each do |pokemon|
      assign_alolan_form(pokemon) if pokemon['alolan_form']
    end
  end

  def create_pokemon(pokemon)
    p = Pokemon.new
    p.name = pokemon['name']
    p.name_en = pokemon['name_en']
    p.num = pokemon['num']
    p.alolan = pokemon['alolan']
    p.candy_id = Candy.where(name: pokemon['candy']).first.id if pokemon['candy']
    p.candy_distance = pokemon['candy_distance']
    p.pc_max = pokemon['pc_max']
    p.atk = pokemon['atk']
    p.def = pokemon['def']
    p.sta = pokemon['sta']
    p.flee_rate = pokemon['flee_rate']
    p.capture_rate = pokemon['capture_rate']
    p.generation_id = pokemon['generation']
    p.pokedex_entry = pokemon['pokedex_entry']
    p.comment = pokemon['comment']
    p.types.clear
    p.types << Type.where(name: pokemon['type_1']).or(Type.where(name: pokemon['type_2']))
    p.attacks.clear
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

  def assign_alolan_form(pokemon)
    p = Pokemon.find_by(num: pokemon['num'])
    p.alolan_form_id = Pokemon.find_by(num: pokemon['alolan_form']).id
    p.save
  end

## PUIS LES OEUFS

  def create_eggs
    @@eggs.each do |egg|
      create_egg(egg) unless Egg.where(name: egg['name']).first
    end
  end

  def create_egg(egg)
    e = Egg.new
    e.name = egg['name']
    e.desc = egg['desc']
    egg['pokemons'].each do |p|
      e.pokemons << Pokemon.where(num: p['num']).first
    end
    e.save
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

## PUIS LES SKINS ALTERNATIFS

  def create_alternative_skins
    @@alternative_skins.each do |skin|
      create_alternative_skin(skin) if AlternativeSkin.where(pokemon_id: Pokemon.find_by(num: skin['pokemon_num']).id).where(name: skin['name']).empty?
    end
  end

  def create_alternative_skin(skin)
    s = AlternativeSkin.new
    s.name = skin['name']
    s.name_en = skin['name_en']
    s.pokemon_id = Pokemon.find_by(num: skin['pokemon_num']).id
    s.desc = skin['desc']
    s.shiny = skin['shiny']
    s.nametag = skin['nametag']
    s.save
  end

## PUIS LES RECHERCHES

  def create_special_researches
    @@special_researches.each do |research|
      create_special_research(research) unless SpecialResearch.find_by(name: research['name'])
    end
  end

  def create_special_research(research)
    r = SpecialResearch.new
    r.name = research['name']
    r.is_active = research['is_active']
    r.desc = research['desc']
    r.save
    create_research_steps(research['steps'],SpecialResearch.find_by(name: research['name']))
  end

  def create_research_steps(steps,research)
    steps.each do |step|
      create_research_step(step,research)
    end
  end

  def create_research_step(step,research)
    s = ResearchStep.new
    s.name = step['name']
    s.step_id = step['step_id']
    s.special_research_id = research.id
    s.save
    create_research_tasks(step['tasks'],ResearchStep.find_by(name: step['name']))
    create_research_rewards(step['rewards'],ResearchStep.find_by(name: step['name']))
  end

  def create_research_tasks(tasks,step)
    tasks.each do |task|
      create_research_task(task,step)
    end
  end

  def create_research_task(task,step)
    t = ResearchTask.new
    t.name = task['name']
    t.desc = task['desc']
    t.reward_type = task['reward_type']
    t.pokemon_reward = Pokemon.find_by(name: task['pokemon_reward']).id if task['pokemon_reward']
    t.item_reward = Item.find_by(name: task['item_reward']).id if task['item_reward']
    t.xp_reward = task['xp_reward'] if task['xp_reward']
    t.research_step_id = step.id
    t.save
  end

  def create_research_rewards(rewards,step)
    rewards.each do |reward|
      create_research_reward(reward,step)
    end
  end

  def create_research_reward(reward,step)
    r = ResearchReward.new
    r.name = reward['name']
    r.reward_type = reward['reward_type']
    r.quantity = reward['quantity']
    r.research_step_id = step.id
    r.item_id = Item.find_by(name: reward['item']).id if reward['item']
    r.pokemon_id = Pokemon.find_by(name: reward['pokemon']).id if reward['pokemon']
    r.candy_id = Candy.find_by(name: reward['candy']).id if reward['candy']
    r.save
  end

end

















