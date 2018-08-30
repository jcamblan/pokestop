module PokemonHelper

  def evolutions_block(id)

  	evolutions = Evolution.where(pokemon_id: id)

  	unless evolutions.nil?

  		# DIV

  		evolutions.each do |e|

  			# création d'un DIV

  			evolutions_block(e.after_evolution)
  			
  		end

      

      evolutions = Evolution.where()

  	end

  end

end
