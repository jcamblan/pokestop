class GenerationsController < ApplicationController

  breadcrumb 'Générations', :generations_path

  def show
    @generation = Generation.friendly.find(params[:id])
    @pokemons = Pokemon.where(generation_id: @generation.id).order(params[:order]).order(num: :asc)
    breadcrumb @generation.name, generation_path(@generation)
    @max_atk = Pokemon.max_atk
    @max_def = Pokemon.max_def
    @max_sta = Pokemon.max_sta
    @max_pc = Pokemon.max_pc_max
  end
  def index
    @generations = Generation.all.order(:id)
  end
end