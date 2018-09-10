namespace :types do
  desc "TODO"

  task update: :environment do
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

end
