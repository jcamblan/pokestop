class AttackController < ApplicationController
  def show
    @attack = Attack.find(params[:id])
    @pokemons = @attack.pokemons.page(params[:page]).per(25)
  end
  def index
    @attacks = Attack.all.order(:name).page(params[:page]).per(25)
  end
end