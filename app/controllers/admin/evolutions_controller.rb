class Admin::EvolutionsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Evolutions', :admin_evolutions_path

  def index
    @evolutions = Evolution.all
  end

  def edit
    @evolution = Evolution.find(params[:id])
    breadcrumb @evolution.title, edit_admin_evolution_path(@evolution)
  end

  def new
    @evolution = Evolution.new
  end

  def create
    @evolution = Evolution.new(evolution_params)
    if @evolution.save
      redirect_to edit_admin_evolution_path(@evolution)
    else
      render 'new'
    end
  end

  def update
    @evolution = Evolution.find(params[:id])
    if @evolution.update(evolution_params)
      redirect_to admin_evolutions_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def evolution_params
      params.require(:evolution).permit(:title, :title_en, :pokemon_id, :first_form, :after_evolution, :candies, :item_id)
    end
end