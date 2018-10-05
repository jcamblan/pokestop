class PokemonsController < ApplicationController

  def index
    @filterrific = initialize_filterrific(
      Pokemon,
      params[:filterrific],
      :select_options => {
        with_generation_id: Generation.options_for_select,
        with_type_id: Type.options_for_select,
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
    @pokemon = Pokemon.find_by(num: params[:num])
    @evolutions = @pokemon.first_form if @pokemon.can_evolve? || @pokemon.is_evolution?
    @combo_list = AttacksCombo.new.get_combos_array(@pokemon)
  end

end
