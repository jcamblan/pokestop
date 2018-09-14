json.generations do 
  json.array!(@generations) do |generation|
    json.id generation.id
    json.name generation.name
  end
end

json.candies do 
  json.array!(@candies) do |candy|
    json.name candy.name
    json.primary_color candy.primary_color
    json.secondary_color candy.secondary_color
  end
end

json.types do 
  json.array!(@types) do |type|
    json.name type.name
  end
end

json.item_categories do 
  json.array!(@item_categories) do |item_category|
    json.name item_category.name
  end
end

json.items do 
  json.array!(@items) do |item|
    json.name item.name
    json.description item.desc
    json.category item.category.name
  end
end

json.pokemons do 
  json.array!(@pokemons) do |pokemon|
  	json.name pokemon.name
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
    json.name evolution.title
    json.first_form Pokemon.find(evolution.first_form).name
    json.before_evolution Pokemon.find(evolution.pokemon_id).name
    json.after_evolution Pokemon.find(evolution.after_evolution).name
    json.candies evolution.candies
    json.item evolution.item.name if evolution.item
  end
end