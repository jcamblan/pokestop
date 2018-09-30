class Admin::PokemonsController < ApplicationController
  layout 'admin'

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Pokemons', :admin_pokemons_path

  def index
    @pokemons = Pokemon.all.order(:num)
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
    breadcrumb @pokemon.name, edit_admin_pokemon_path(@pokemon)
  end

  def new
    @pokemon = Pokemon.new
  end

  def update
    @pokemon = Pokemon.find(params[:id])
    if @pokemon.update(pokemon_params)
      redirect_to admin_pokemons_path
    else
      render 'edit'
    end
  end

  private

    def pokemon_params
      params.require(:pokemon).permit(:num, :name, :name_en, :atk, :def, :sta, :pc_max,
                                      :generation_id, :candy_id, :candy_distance,
                                      :capture_rate, :flee_rate, {:egg_ids => []}, {:type_ids => []}, {:attack_ids => []},
                                      :pokedex_entry, :comment)
    end
end