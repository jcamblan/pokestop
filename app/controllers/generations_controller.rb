class GenerationsController < ApplicationController

  breadcrumb 'Générations', :generations_path

  def show
    @generation = Generation.friendly.find(params[:id])
    @pokemons = Pokemon.where(generation_id: @generation.id).order(params[:order]).order(num: :asc)
    breadcrumb @generation.name, generation_path(@generation)
  end
  def index
    @generations = Generation.all.order(:id)
  end
end