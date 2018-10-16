class PokemonsController < ApplicationController

  breadcrumb 'Pokémons', :pokemons_path

  def index
    @pokemons = Pokemon.all.order(num: :asc)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @pokemon = Pokemon.friendly.find(params[:id])
    @evolutions = @pokemon.first_form if @pokemon.can_evolve? || @pokemon.is_evolution?
    @movesets = @pokemon.movesets
    breadcrumb @pokemon.name, pokemon_path(@pokemon)
  end

end
