module PokemonHelper

  def pokemon_summary(pokemon)
    types_string = ""
    weaknesses_string = ""
    movesets_string = ""
    best_moveset = pokemon.movesets.sort_by{|e| -e[:raw_attacking_dps]}.first
    movesets_string = best_moveset ? "Sa meilleure combinaison d'attaques est #{best_moveset.fast_attack.name} + #{best_moveset.charge_attack.name}. " : ""
    pc_string = pokemon.pc_max ? "Il peut avoir jusqu'à #{pokemon.pc_max} PC." : ""
    pokemon.types.each do |type|
      types_string += ", " unless type == pokemon.types.first || type == pokemon.types.last
      types_string += " et " if type == pokemon.types.last
      types_string += type.name
    end
    weaknesses = pokemon.types_very_strong_against_it ? (pokemon.types_strong_against_it + pokemon.types_very_strong_against_it).uniq : pokemon.types_strong_against_it
    weaknesses.each do |weaknesse|
      weaknesses_string += ", " unless weaknesse == weaknesses.first || weaknesse == weaknesses.last
      weaknesses_string += " et " if weaknesse == weaknesses.last
      weaknesses_string += weaknesse.name
    end
    return "#{pokemon.name} est un Pokémon de type #{types_string}. Il est vulnérable aux types #{weaknesses_string}. #{movesets_string}#{pc_string}"
  end

  def display_pokemon_sprite(pokemon)
    image_tag "pokemon/#{pokemon.generation.id}-#{pokemon.generation.name.parameterize}/#{pokemon.num}.png", alt: pokemon.name
  end

  def display_pokemon_small_sprite(pokemon)
    image_tag "pokemon/#{pokemon.generation.id}-#{pokemon.generation.name.parameterize}/small-#{pokemon.num}.png", alt: pokemon.name
  end

  def display_alt_skin_sprite(skin)
    image_tag "pokemon/#{skin.pokemon.generation.id}-#{skin.pokemon.generation.name.parameterize}/#{skin.pokemon.num}-#{skin.nametag}.png", alt: skin.pokemon.name
  end

  def type_image(type)
    image_tag "types/#{type.name_en.parameterize}.png", alt: type.name, title: type.name
  end

  def stat_bar(stat_name,stat,stat_max)
    content_tag :div, class: 'stats__progress' do
      content_tag :div, class: "stats__progress-bar stats__progress-bar--#{stat_name}", style: "width: #{stat.to_f/stat_max*100}%", role: 'progressbar', aria: {valuemin: '0', valuemax: stat_max, valuenow: stat} do
        display_name = case stat_name
          when 'pc_max' then 'PC : '
          when 'atk' then 'ATTAQUE : '
          when 'def' then 'DEFENSE : '
          when 'sta' then 'ENDURANCE : '
          else ''
        end
        content_tag :span, display_name + stat.to_s
      end
    end
  end

  def small_stat_bar(stat_name,stat,stat_max)
    content_tag :div, class: 'stats__progress' do
      content_tag :div, class: "stats__progress-bar stats__progress-bar--#{stat_name}", style: "width: #{stat.to_f/stat_max*100}%", role: 'progressbar', aria: {valuemin: '0', valuemax: stat_max, valuenow: stat} do
        content_tag :span, stat.to_s
      end
    end
  end

  def energy_bars(attack)
    image_tag "attacks/#{attack.energy_bars}-energy.png"
  end

  def format_capture_rate(number)
    capture_rate = number
    if capture_rate > 100
      capture_rate = 100
    end
    return capture_rate.round
  end

  def pokemon_sprite_url(pokemon)
    return "pokemon/#{pokemon.generation.id}-#{pokemon.generation.name.parameterize}/#{pokemon.num}.png"
  end
end
