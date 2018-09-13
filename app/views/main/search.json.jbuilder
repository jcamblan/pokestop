json.pokemons do 
  json.array!(@pokemons) do |pokemon|
  	json.name pokemon.name
  	json.url pokemon_path(pokemon)
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