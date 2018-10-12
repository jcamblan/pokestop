class Admin::PokemonsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Pokemons', :admin_pokemons_path

  def index
    @pokemons = Pokemon.all.order(:num)

  end

  def edit
    @pokemon = Pokemon.friendly.find(params[:id])
    breadcrumb @pokemon.name, edit_admin_pokemon_path(@pokemon)
  end

  def new
    @pokemon = Pokemon.new
  end

  def update
    @pokemon = Pokemon.friendly.find(params[:id])
    if @pokemon.update(pokemon_params)
      redirect_to admin_pokemons_path
    else
      render 'edit'
    end
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)
    if @pokemon.save
      redirect_to admin_pokemons_path
    else
      render 'new'
    end  
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def pokemon_params
      params.require(:pokemon).permit(:num, :name, :name_en, :atk, :def, :sta, :pc_max,
                                      :generation_id, :candy_id, :candy_distance, :alolan,
                                      :capture_rate, :flee_rate, :alolan_form_id, {:egg_ids => []}, {:type_ids => []}, {:attack_ids => []},
                                      :pokedex_entry, :comment)
    end
end