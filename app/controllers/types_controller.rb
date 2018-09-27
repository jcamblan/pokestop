class TypesController < ApplicationController
  def show
    @type = Type.find(params[:id])
    @pokemons = @type.pokemons.page(params[:page]).per(25)
    @attacks = @type.attacks
  end
  def index
    @types = Type.all.order(:name)
  end
end