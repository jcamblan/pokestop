class TypesController < ApplicationController

  breadcrumb 'Types', :types_path

  def show
    @type = Type.find(params[:id])
    @pokemons = @type.pokemons.page(params[:page]).per(25)
    @attacks = @type.attacks
    breadcrumb @type.name, type_path(@type)
  end
  def index
    @types = Type.all.order(:name)
  end
end