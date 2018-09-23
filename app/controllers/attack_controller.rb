class AttackController < ApplicationController
  def show
    @attack = Attack.find(params[:id])
    @filterrific = initialize_filterrific(
      @attack.pokemons,
      params[:filterrific],
      :select_options => {
        with_generation_id: Generation.options_for_select,
        with_on_prod: ['Filtrer']
      }
    ) or return
    @pokemons = @filterrific.find.page(params[:page])
  end
  def index
    @attacks = Attack.all.order(:name).page(params[:page]).per(25)
  end
end