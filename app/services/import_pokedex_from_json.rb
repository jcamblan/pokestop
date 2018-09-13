class ImportPokedexFromJson

  # def update_gen

  #   pokedex = Pokemon.all

  #   pokedex.each do |p|

  #     if p.id >= 1 && p.id <= 151
  #       generation_id = 1
  #     elsif p.id >= 152 && p.id <= 251
  #       generation_id = 2
  #     elsif p.id >= 252 && p.id <= 386
  #       generation_id = 3
  #     elsif p.id >= 387 && p.id <= 493
  #       generation_id = 4
  #     elsif p.id >= 494 && p.id <= 649
  #       generation_id = 5
  #     elsif p.id >= 650 && p.id <= 721
  #       generation_id = 6
  #     elsif p.id >= 722 && p.id <= 807
  #       generation_id = 7
  #     end

  #     p.generation_id = generation_id
  #     p.save

  #   end

  # end

  # def get_pokemons
  #   pokedex_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_megapokedex.json'))))

  #   pokedex_file.each do |p|

  #     #byebug

  #     check_db = Pokemon.where(num: p.dig('num'))

  #     if check_db.empty?

  #       type_1 = Type.where(name: p.dig('type_1')).first.id

        

  #       if p.dig('type_2') == ""
  #         type_2 = ""
          
  #       else
          
  #         type_2 = Type.where(name: p.dig('type_2')).first.id
  #       end

  #       Pokemon.create(name: p.dig('name_fr'), num: p.dig('num'), type_1: type_1, type_2: type_2, generation_id: 1)

  #     end

  #   end

  # end

  def update_pokemons

    pokedex_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_pokedex.json'))))    

    pokedex_file.each do |p|

      pokemon = Pokemon.where(num: p.dig('num')).first

      unless pokemon.nil?

        type = p.dig('type')

        pokemon.type_1 = Type.where(name: type.first).first.id
        pokemon.type_2 = Type.where(name: type.second).first.id unless type.second.nil?

        pokemon.save

      end

    end

  end

  # def get_types
  #   types_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_types.json'))))

  #   types_file.each do |t|

  #     check_db = Type.where(name: t.dig('fr'))

  #     if check_db.empty?
  #       Type.create(name: t.dig('fr'))
  #     end

  #   end

  # end

  def get_evolutions # sauf candies et item

    pokedex_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_pokedex.json'))))    

    pokedex_file.reverse_each do |p|

      pokemon = Pokemon.where(num: p.dig('num')).first
      check_db = Evolution.where(pokemon_id: pokemon.id)
      next_evos = p.dig('next_evolution')

      if check_db.empty? #il faut vérifier que les évolutions qu'on va ajouter n'existent pas déjà

        next_evos.each do |e| 

          Evolution.create(pokemon_id: pokemon_id, after_evolution: after_evolution)

        end

      end

    end

  end


end