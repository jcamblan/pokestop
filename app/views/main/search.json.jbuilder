json.pokemons do 
  json.array!(@pokemons) do |pokemon|
  	json.name pokemon.name
    json.name_en pokemon.name_en
    json.num pokemon.num
  	json.url pokemon_path(pokemon)
  end
end

json.item_categories do 
  json.array!(@item_categories) do |item_category|
    json.name item_category.name
    json.name_en item_category.name_en
    json.url item_category_path(item_category)
  end
end

json.items do 
  json.array!(@items) do |item|
  	json.name item.name
  	json.url item_path(item)
  end
end

json.generations do 
  json.array!(@generations) do |generation|
  	json.name generation.name
  	json.url generation_path(generation)
  end
end

json.attacks do 
  json.array!(@attacks) do |attack|
    json.name attack.name
    json.name_en attack.name_en
    json.url attack_path(attack)
  end
end