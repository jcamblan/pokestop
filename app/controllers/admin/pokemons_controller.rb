class Admin::PokemonsController < ApplicationController
  layout 'admin'

  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  def new
    @pokemon = Pokemon.new
  end

end