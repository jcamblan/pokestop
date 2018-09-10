class PokemonController < ApplicationController

  def share

  	list = Json.new

  	list.create

  	render json: list

  end


  def evolutions_block(id)

    block_evolutions = Array.new

    pokemon = Pokemon.find(id)

    if pokemon.can_evolve? || pokemon.is_evolution?

      first_form = Evolution.where(pokemon_id: id).first.first_form

      block_evolutions << {
        id: first_form,
        name: Pokemon.find(first_form).name,
        evolutions: get_evolutions(first_form)
      }

    end

    return block_evolutions
  	
  end

  def get_evolutions(id)
    evolutions = Evolution.where(pokemon_id: id)

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
