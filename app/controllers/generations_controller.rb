class GenerationsController < ApplicationController

  breadcrumb 'Générations', :generations_path

  def show
    @generation = Generation.find(params[:id])
    @pokemons = Pokemon.where(generation_id: params[:id]).order(params[:order]).order(:num).page(params[:page]).per(25)
    breadcrumb @generation.name, generation_path(@generation)
  end
  def index
    @generations = Generation.all.order(:id)
  end
end