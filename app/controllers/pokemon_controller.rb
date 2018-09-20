class PokemonController < ApplicationController

  def index
    @pokemons = Pokemon.all.order(params[:order]).page(params[:page]).per(25)
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @evolutions = @pokemon.first_form if @pokemon.can_evolve? || @pokemon.is_evolution?
  end

end
