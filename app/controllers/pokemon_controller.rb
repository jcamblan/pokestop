class PokemonController < ApplicationController

  def index
    #@pokemons = Pokemon.all.order(params[:order]).page(params[:page]).per(25)

    @filterrific = initialize_filterrific(
      Pokemon,
      params[:filterrific],
      :select_options => {
        sorted_by: Pokemon.options_for_sorted_by,
        with_generation_id: Generation.options_for_select,
        with_on_prod: ['Filtrer']
      }
    ) or return
    @pokemons = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @evolutions = @pokemon.first_form if @pokemon.can_evolve? || @pokemon.is_evolution?
  end

end
