class Scrapper

  require 'open-uri'

  def get_pokemon(num)

    pokemon = Pokemon.where(num: num).first

    url =  Addressable::URI.normalized_encode("https://www.pokebip.com/pokedex/6G_p#{num}_#{pokemon.name}.html")

    doc = Nokogiri::HTML(open(url))

    evols = doc.css('div#g6_genealogie table tr[3] td[3] div.g6_evos')

    evols.each do |e|

      evol = e.css('div.g6_evos_p a')

      unless evol.empty?

        evol_num = evol[0]['href'].gsub(/6G_p(.*)_(.*)/, '\1').to_s.rjust(3, "0")
        evol_name = evol[1].text

        evol_id = Pokemon.where(num: evol_num).first.id

        pokemon_name = pokemon.name
        evol_name = Pokemon.find(evol_id).name

        title = "#{pokemon_name} > #{evol_name}"

        check_db = Evolution.where(after_evolution: evol_id).first

        if check_db.nil?

          Evolution.create(pokemon_id: pokemon.id, after_evolution: evol_id, title: title)

        end

      end
    
    end

  end

  def aleajactaest(gen)
    
    pokedex = Pokemon.where(generation_id: gen)

    pokedex.each do |p|

      get_pokemon(p.num)

    end

  end

  def name_evolutions

  	evolutions = Evolution.all

  	evolutions.each do |e|

  		pokemon_name = Pokemon.find(e.pokemon_id).name
  		evol_name = Pokemon.find(e.after_evolution).name

  		e.title = "#{pokemon_name} > #{evol_name}"
  		e.save

  	end

  end

  def get_first_form

  	evolutions = Evolution.all

  	evolutions.each do |e|

  	  if e.first_form == 0

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

end





