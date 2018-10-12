module PokemonHelper

  def display_pokemon_sprite(pokemon)
    image_tag "pokemon/#{pokemon.generation.id}-#{pokemon.generation.name.parameterize}/#{pokemon.num}.png"
  end

  def display_alt_skin_sprite(skin)
    image_tag "pokemon/#{skin.pokemon.generation.id}-#{skin.pokemon.generation.name.parameterize}/#{skin.pokemon.num}-#{skin.nametag}.png"
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
