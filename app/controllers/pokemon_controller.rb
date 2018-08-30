class PokemonController < ApplicationController

  def share

  	list = Json.new

  	list.create

  	render json: list

  end


  def evolutions_block(id)

  	evolutions = Evolution.where(pokemon_id: id).first

  	block_evolutions = Array.new

  	unless evolutions.nil?

  	  evolutions.each do |e|

  	    evolution << {
  	    	id: Evolution.where(pokemon_id: e.after_evolution).first.pokemon_id
  	    } 
  	  	
  	  end
  		
  	end
  	
  end


  def show

  	pokemon = Pokemon.where(name: params[:name]).first

  	@id = pokemon.id
  	@num = pokemon.num
  	@name = pokemon.name
  	@type_1 = Type.find(pokemon.type_1).name
  	if pokemon.type_2.nil?
  	  @type_2 = ''
  	else
  	  @type_2 = Type.find(pokemon.type_2).name
  	end

  	@evolution = Evolution.where(pokemon_id: pokemon.id).first.first_form


  end

end
