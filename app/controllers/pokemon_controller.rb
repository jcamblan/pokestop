class PokemonController < ApplicationController

  def share

  	list = Json.new

  	list.create

  	render json: list

  end


  def evolutions_block(id)

    evolutions = Evolution.where(pokemon_id: id)

  	block_evolutions = Array.new

    block_evolutions << {
      id: Evolution.where(pokemon_id: id).first.first_form,
      name: Pokemon.where(id: Evolution.where(pokemon_id: id).first.first_form).first.name,
      evolutions: get_evolutions(Evolution.where(pokemon_id: id).first.first_form)
    }

    return block_evolutions
  	
  end

  def get_evolutions(id)
    evolutions = Evolution.where(pokemon_id: id)

    block_evolutions = Array.new
    next_forms = Array.new

    unless evolutions.nil?

      evolutions.each do |e|

        next_forms << {
          id: e.after_evolution,
          name: Pokemon.where(id: e.after_evolution).first.name,
          evolutions: get_evolutions(e.after_evolution)
        } 
        
      end
      
    end

    return next_forms
  end


  def show

  	@pokemon = Pokemon.where(name: params[:name]).first

  	@evolutions = evolutions_block(@pokemon.id)


  end

end
