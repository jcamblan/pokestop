class PokemonsController < ApplicationController

  breadcrumb 'Pokémons', :pokemons_path

  def index
    @pokemons = Pokemon.where(:generation_id => Generation.where(on_prod: true).ids).order(num: :asc)
    @max_atk = Pokemon.max_atk
    @max_def = Pokemon.max_def
    @max_sta = Pokemon.max_sta
    @max_pc = Pokemon.max_pc_max
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @pokemon = Pokemon.friendly.find(params[:id])
    @evolutions = @pokemon.first_form if @pokemon.can_evolve? || @pokemon.is_evolution?
    @movesets = @pokemon.movesets
    @max_atk = Pokemon.max_atk
    @max_def = Pokemon.max_def
    @max_sta = Pokemon.max_sta
    @max_pc = Pokemon.max_pc_max
    breadcrumb @pokemon.name, pokemon_path(@pokemon)
  end

end
