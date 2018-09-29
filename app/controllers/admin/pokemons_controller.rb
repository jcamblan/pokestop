class Admin::PokemonsController < ApplicationController
  layout 'admin'

  def index
    @pokemons = Pokemon.all
  end

  def edit
    @pokemon = Pokemon.find(params[:id])
  end

  def new
    @pokemon = Pokemon.new
  end

  def update
    pokemon = Pokemon.find(params[:id])
    pokemon.num = params[:pokemon][:num]
    pokemon.name_en = params[:pokemon][:name_en]
    pokemon.pc_max = params[:pokemon][:pc_max]
    pokemon.atk = params[:pokemon][:atk]
    pokemon.def = params[:pokemon][:def]
    pokemon.sta = params[:pokemon][:sta]
    pokemon.generation_id = params[:pokemon][:generation_id]
    pokemon.candy_id = params[:pokemon][:candy_id]
    pokemon.candy_distance = params[:pokemon][:candy_distance]
    pokemon.capture_rate = params[:pokemon][:capture_rate]
    pokemon.flee_rate = params[:pokemon][:flee_rate]
    pokemon.pokedex_entry = params[:pokemon][:pokedex_entry]
    pokemon.comment = params[:pokemon][:comment]
    pokemon.eggs = Egg.where(id: params[:pokemon][:egg_ids]) unless Egg.where(id: params[:pokemon][:egg_ids]).empty? 
    pokemon.types = Type.where(id: params[:pokemon][:type_ids]) unless Type.where(id: params[:pokemon][:type_ids]).empty?
    pokemon.attacks = Attack.where(id: params[:pokemon][:attack_ids]) unless Attack.where(id: params[:pokemon][:attack_ids]).empty?
    pokemon.save
    if pokemon.save
      redirect_to admin_pokemons_path
    else
      redirect_to edit_admin_pokemon_path(pokemon)
    end
  end

  private

    def pokemon_params
      params.require(:pokemon).permit(:num, :name, :name_en, :atk, :def, :sta, :pc_max,
                                      :generation_id, :candy_id, :candy_distance,
                                      :capture_rate, :flee_rate, :egg_ids, :type_ids, :attack_ids,
                                      :pokedex_entry, :comment)
    end
end