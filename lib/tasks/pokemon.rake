namespace :pokemons do
  desc "TODO"

  task create_generations: :environment do
    generations = [
          {'name': 'Kanto' },
          {'name': 'Johto' },
          {'name': 'Hoenn' },
          {'name': 'Sinnoh'},
          {'name': 'Unova' },
          {'name': 'Kalos' },
          {'name': 'Alola' }
        ]
    generations.each do |g|
      Generation.create(name: g[:name]) unless Generation.where(name: g[:name]).first
    end
  end

  task create_pokedex: :environment do
    pokedex_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_megapokedex.json'))))

    pokedex_file.each do |p|

      check_db = Pokemon.where(num: p.dig('num'))

      if check_db.empty?

        type_1 = Type.where(name: p.dig('type_1')).first.id

        if p.dig('type_2') == ""
          type_2 = ""
        else
          type_2 = Type.where(name: p.dig('type_2')).first.id
        end

        Pokemon.create(name: p.dig('name_fr'), candy_id: 1, num: p.dig('num'), type_1: type_1, type_2: type_2, generation_id: 1)

      end

    end

  end

  # task get_evolutions: :environment do
  #   pokedex_file = JSON.parse(File.read(File.open(File.join(Rails.root, 'lib', 'assets', '_pokedex.json'))))    

  #   pokedex_file.reverse_each do |p|

  #     pokemon = Pokemon.where(num: p.dig('num')).first
  #     check_db = Evolution.where(pokemon_id: pokemon.id)
  #     next_evos = p.dig('next_evolution')

  #     if check_db.empty? #il faut vérifier que les évolutions qu'on va ajouter n'existent pas déjà

  #       next_evos.each do |e| 
  #         Evolution.create(pokemon_id: pokemon_id, after_evolution: after_evolution)

  #       end

  #     end

  #   end
  # end

  task update_types: :environment do
    pokedex = Pokemon.all

    pokedex.each do |pokemon|

      type1 = Type.find(pokemon.type_1)
      if pokemon.type_2
        type2 = Type.find(pokemon.type_2)
      end

      pokemon.types << type1 unless type1.nil?

      if type2
        pokemon.types << type2
      end
    end
  end

  task assign_gen: :environment do
    pokedex = Pokemon.all

    pokedex.each do |p|

      if p.id >= 1 && p.id <= 151
        generation_id = 1
      elsif p.id >= 152 && p.id <= 251
        generation_id = 2
      elsif p.id >= 252 && p.id <= 386
        generation_id = 3
      elsif p.id >= 387 && p.id <= 493
        generation_id = 4
      elsif p.id >= 494 && p.id <= 649
        generation_id = 5
      elsif p.id >= 650 && p.id <= 721
        generation_id = 6
      elsif p.id >= 722 && p.id <= 807
        generation_id = 7
      end

      p.generation_id = generation_id
      p.save
    end
  end

end
