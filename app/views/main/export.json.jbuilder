json.generations do 
  json.array!(@generations) do |generation|
    json.id generation.id
    json.name generation.name
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
    json.type_1 pokemon.types.first.name
    json.type_2 pokemon.types.second.name if pokemon.types.second
    json.candy pokemon.candy.name if pokemon.candy
    json.candy_distance pokemon.candy_distance
    json.pc_max pokemon.pc_max
    json.pv_max pokemon.pv_max
    json.generation pokemon.generation_id
    json.pokedex_entry pokemon.pokedex_entry
    json.comment pokemon.comment
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