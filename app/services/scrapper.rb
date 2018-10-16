class Scrapper

  def get_pokemon_datas(pokemon)
    url =  Addressable::URI.normalized_encode("https://pokemongo.gamepress.gg/pokemon/#{pokemon.num.to_i}")
    doc = Nokogiri::HTML(open(url))
    pokemon_stats = doc.css('div#pokemon-stats')
    pokemon.pc_max = pokemon_stats.css('span.max-cp-number').text.to_i
    stats = pokemon_stats.css('div.stats-container div.pokemon-stats div.header-stats')
    pokemon.atk = stats[0].css('span').text.gsub('ATK', '').to_i
    pokemon.def = stats[1].css('span').text.gsub('DEF', '').to_i
    pokemon.sta = stats[2].css('span').text.gsub('STA', '').to_i
    pokemon.save
    puts "#{pokemon.name} : OK"
  end

  def get_pokemons_datas
    generations = Generation.where(id: 4)
    generations.each do |g|
      g.pokemons.each do |p|
        unless p.alolan == true || p.num == "413"
          get_pokemon_datas(p)
        end
      end
    end
  end

  def get_first_form
    evolutions = Evolution.all
    evolutions.each do |e|
      if e.first_form.nil?
        pokemon_num = Pokemon.find(e.pokemon_id).num
        url =  Addressable::URI.normalized_encode("https://www.serebii.net/pokedex-sm/#{pokemon_num}.shtml")
        doc = Nokogiri::HTML(open(url))
        evol_num = doc.css('table.evochain tr td[1] a[1]')[0]['href'].gsub(/\/pokedex-sm\/(.*).shtml/, '\1').to_s.rjust(3, "0")
        e.first_form = evol_num
        e.save
      end
    end
  end

  def get_candies
    url =  Addressable::URI.normalized_encode("https://www.pokebip.com/page/jeuxvideo/pokemon_go/pokemon")
    doc = Nokogiri::HTML(open(url))
    evols = doc.css('table.bipcode.tablesorter tbody tr')
    evols.each do |e|
      evol_num = e.css('td[1]')[0].text.to_s.gsub(/#(.*?) (.*)/, '\1').to_s.rjust(3, "0")
      evol_id = Pokemon.where(num: evol_num).first.id
      evol_candies = e.css('td[2]')[0].text.gsub(/ Bonbons/, '')
      pokemon = Evolution.where(pokemon_id: evol_id).first
      unless pokemon.nil?
        pokemon.candies = evol_candies
        pokemon.save
      end
    end
  end

  def assign_attacks
    generations = Generation.where(name: 'Sinnoh')
    generations.each do |g|
      g.pokemons.each do |p|
        unless p.alolan == true || p.num == "413"
          get_attacks(p)
        end
      end
    end
  end

  def get_attacks(pokemon)
    url =  Addressable::URI.normalized_encode("https://pokemongo.gamepress.gg/pokemon/#{pokemon.num.to_i}")
    doc = Nokogiri::HTML(open(url))
    fast_attacks = doc.css('div#pokemon-primary-moves div.primary-move article').each do |a|
      scrapped_name = a.css('div.primary-move-title a span').text
      pokemon.attacks << Attack.where(name_en: scrapped_name).first if Attack.where(name_en: scrapped_name)
    end
    charge_attacks = doc.css('div#pokemon-secondary-moves div.secondary-move article').each do |a|
      scrapped_name = a.at('div.primary-move-title a span').text
      pokemon.attacks << Attack.where(name_en: scrapped_name).first if Attack.where(name_en: scrapped_name)
    end
  end


  def get_attacks_type
    #url =  Addressable::URI.normalized_encode("https://pokemongo.gamepress.gg/charge-moves")
    url =  Addressable::URI.normalized_encode("https://pokemongo.gamepress.gg/fast-moves")
    doc = Nokogiri::HTML(open(url))
    attacks = doc.css('div.view-moves div.view-content table#sort-table tbody tr').each do |a|
      type = a.attribute('class').value
      attack_name_en = a.css('td')[0].css('a').text
      if Attack.where(name_en: attack_name_en).first
        attack = Attack.where(name_en: attack_name_en).first
        attack.type_id = Type.where(name_en: type).first.id
        attack.save
      end
    end
  end

  def get_attacks_power
    url =  Addressable::URI.normalized_encode("https://pokemongo.gamepress.gg/charge-moves")
    #url =  Addressable::URI.normalized_encode("https://pokemongo.gamepress.gg/fast-moves")
    doc = Nokogiri::HTML(open(url))
    attacks = doc.css('div.view-moves div.view-content table#sort-table tbody tr').each do |a|
      power = a.css('td')[3].text
      attack_name_en = a.css('td')[0].css('a').text
      if Attack.where(name_en: attack_name_en).first
        attack = Attack.where(name_en: attack_name_en).first
        attack.power = power.to_i
        attack.save
      end
    end
  end
end