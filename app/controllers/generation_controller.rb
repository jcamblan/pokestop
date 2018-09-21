class GenerationController < ApplicationController
  def show
    @pokemons = Pokemon.where(generation_id: params[:id]).order(params[:order]).order(:num).page(params[:page]).per(25)
  end
  def index
    @generations = Generation.all.order(:id)
  end
end