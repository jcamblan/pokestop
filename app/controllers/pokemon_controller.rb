class PokemonController < ApplicationController

  def index
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @evolutions = @pokemon.first_form if @pokemon.can_evolve? || @pokemon.is_evolution?
  end

end
