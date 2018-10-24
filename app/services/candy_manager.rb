class CandyManager
  require 'csv'

  def update_colors
    CSV.read(Rails.root.join('lib', 'seeds', 'colors.csv'), headers: true).each do |row|
      if pokemon = Pokemon.find_by(name_en: row['pokemon'])
        candy = Candy.find_by(name: "Bonbon #{pokemon.name}")
        candy.primary_color = row ['primaryColor']
        candy.secondary_color = row['secondaryColor']
        candy.save
      else
        puts "Impossible de trouver le Pokémon #{row['pokemon']}"
      end
    end
  end

  def link_candies_to_pokemon
    Pokemon.where(candy_id: nil).each do |pokemon|
      candify_name = "Bonbon #{pokemon.name}"
      if Candy.find_by(name: candify_name)
        pokemon.candy_id = Candy.find_by(name: candify_name).id
      elsif pokemon.can_evolve? || pokemon.is_evolution?
        pokemon.candy_id = pokemon.first_form.first.candy_id if pokemon.first_form.first.candy_id
      end
      pokemon.save
    end
  end

end