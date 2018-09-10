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

  	pokemon = Pokemon.where(name: params[:name]).first

  	@id = pokemon.id
  	@num = pokemon.num
  	@name = pokemon.name
  	@type_1 = Type.find(pokemon.type_1).name
    @type_1_css = Type.find(pokemon.type_1).class_css
  	unless pokemon.type_2.nil?
  	  @type_2 = Type.find(pokemon.type_2).name
      @type_2_css = Type.find(pokemon.type_2).class_css
  	end

  	@evolution = evolutions_block(pokemon.id)


  end

end
