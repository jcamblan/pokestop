class PokemonController < ApplicationController

  def share

  	list = Json.new

  	list.create

  	render json: list

  end

  def show

  	@pokemon = Pokemon.where(name: params[:name]).first

  	@evolutions = @pokemon.first_form if @pokemon.can_evolve? || @pokemon.is_evolution?

  end

end
