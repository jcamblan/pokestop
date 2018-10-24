json.eggs do 
  json.array!(@eggs) do |egg|
    json.name egg.name
    json.desc egg.desc
    json.pokemons do
      json.array!(egg.pokemons.order(:num)) do |e|
        json.name e.name
        json.num e.num
      end
    end
  end
end

json.generations do 
  json.array!(@generations) do |generation|
    json.id generation.id
    json.name generation.name
    json.on_prod generation.on_prod
  end
end

json.candies do 
  json.array!(@candies) do |candy|
    json.name candy.name
    json.name_en candy.name_en
    json.primary_color candy.primary_color
    json.secondary_color candy.secondary_color
  end
end

json.types do 
  json.array!(@types) do |type|
    json.name type.name
    json.name_en type.name_en
    json.strengths do
      json.array!(type.strengths) do |t|
        json.name_fr t.name
        json.name_en t.name_en
      end
    end
    json.weaknesses do
      json.array!(type.weaknesses) do |t|
        json.name_fr t.name
        json.name_en t.name_en
      end
    end
    json.extreme_weaknesses do
      json.array!(type.extreme_weaknesses) do |t|
        json.name_fr t.name
        json.name_en t.name_en
      end
    end
  end
end

json.attack_categories do 
  json.array!(@attack_categories) do |attack_category|
    json.name attack_category.name
    json.name_en attack_category.name_en
  end
end

json.attacks do 
  json.array!(@attacks) do |attack|
    json.name attack.name
    json.name_en attack.name_en
    json.attack_category attack.attack_category.name
    json.type Type.find(attack.type_id).name
    json.power attack.power
    json.cast_time attack.cast_time
    json.energy_bars attack.energy_bars if attack.energy_bars
    json.epu attack.epu if attack.epu
  end
end

json.item_categories do 
  json.array!(@item_categories) do |item_category|
    json.name item_category.name
    json.name_en item_category.name_en
  end
end

json.items do 
  json.array!(@items) do |item|
    json.name item.name
    json.name_en item.name_en
    json.description item.desc
    json.category item.item_category.name
  end
end

json.pokemons do 
  json.array!(@pokemons) do |pokemon|
    json.name pokemon.name
    json.name_en pokemon.name_en
    json.num pokemon.num
    json.alolan pokemon.alolan
    json.alolan_form pokemon.alolan_form.num if pokemon.alolan_form
    json.type_1 pokemon.types.first.name
    json.type_2 pokemon.types.second.name if pokemon.types.second
    json.candy pokemon.candy.name if pokemon.candy
    json.candy_distance pokemon.candy_distance
    json.pc_max pokemon.pc_max
    json.atk pokemon.atk
    json.def pokemon.def
    json.sta pokemon.sta
    json.flee_rate pokemon.flee_rate
    json.capture_rate pokemon.capture_rate
    json.generation pokemon.generation_id
    json.pokedex_entry pokemon.pokedex_entry
    json.comment pokemon.comment
    json.attacks do
      json.array!(pokemon.attacks) do |a|
        json.name_fr a.name
        json.name_en a.name_en
      end
    end
  end
end

json.evolutions do 
  json.array!(@evolutions) do |evolution|
    json.title evolution.title
    json.title_en evolution.title_en
    json.first_form Pokemon.find(evolution.first_form).num
    json.before_evolution Pokemon.find(evolution.pokemon_id).num
    json.after_evolution Pokemon.find(evolution.after_evolution).num
    json.candies evolution.candies
    json.item evolution.item.name if evolution.item
  end
end

json.alternative_skins do 
  json.array!(@alternative_skins) do |alternative_skin|
    json.name alternative_skin.name
    json.name_en alternative_skin.name_en
    json.pokemon_num alternative_skin.pokemon.num
    json.desc alternative_skin.desc
    json.shiny alternative_skin.shiny
    json.nametag alternative_skin.nametag
  end
end

json.special_researches do
  json.array!(@special_researches) do |research|
    json.name research.name
    json.is_active research.is_active
    json.steps do
      json.array!(research.research_steps.order(:step_id)) do |step|
        json.name step.name
        json.step_id step.step_id
        json.tasks do
          json.array!(step.research_tasks) do |task|
            json.name task.name
            json.desc task.desc
            json.reward_type task.reward_type
            json.pokemon_reward task.reward.name if task.pokemon_reward && task.reward_type == "pokemon"
            json.item_reward task.reward.name if task.item_reward && task.reward_type == "item"
            json.xp_reward task.xp_reward if task.xp_reward && task.reward_type == "xp"
          end
        end
        json.rewards do
          json.array!(step.research_rewards) do |reward|
            json.name reward.name
            json.reward_type reward.reward_type
            json.quantity reward.quantity
            json.pokemon reward.pokemon.name if reward.pokemon
            json.item reward.item.name if reward.item
            json.candy reward.candy.name if reward.candy
          end
        end
      end
    end
  end
end











