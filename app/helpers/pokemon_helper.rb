module PokemonHelper

  def display_sprite(pokemon)
    image_tag "pokemon/#{pokemon.generation.id}-#{pokemon.generation.name.downcase}/#{pokemon.num}"
  end

end
