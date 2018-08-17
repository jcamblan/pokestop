class Json

	def create

		@list = []

		pokedex = Pokemon.all

		pokedex.each do |p|

		  pok = PokeJson.new

		  pok.num = p.num
		  pok.name = p.name
		  pok.type_1 = Type.find(p.type_1).name

		  unless p.type_2.nil?
	        pok.type_2 = Type.find(p.type_2).name
	      end
	      
		  pok.evolutions = []

		  evolution = Array.new

		  evols = Evolution.where(pokemon_id: p.id)

		  evols.each do |e|

		  	new_pokemon = Pokemon.find(e.after_evolution)

		  	evolution.push({
		  	  num: new_pokemon.num,
		  	  name: new_pokemon.name,
		  	  candies: e.candies
		  	})

		  end

		  pok.evolutions = evolution

		  @list.prepend(pok)

		end

	end

end