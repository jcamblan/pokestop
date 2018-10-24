class AttacksController < ApplicationController

  breadcrumb 'Attaques', :attacks_path

  def show
    @attack = Attack.friendly.find(params[:id])
    @filterrific = initialize_filterrific(
      @attack.pokemons,
      params[:filterrific],
      :select_options => {
        with_generation_id: Generation.options_for_select,
        with_on_prod: ['Filtrer']
      }
    ) or return
    @pokemons = @filterrific.find.page(params[:page])
    breadcrumb @attack.name, attack_path(@attack)
    @max_atk = Pokemon.max_atk
    @max_def = Pokemon.max_def
    @max_sta = Pokemon.max_sta
    @max_pc = Pokemon.max_pc_max
  end
  def index
    @attacks = Attack.all.order(:name).page(params[:page]).per(25)
  end
end