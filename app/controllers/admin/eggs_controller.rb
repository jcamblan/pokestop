class Admin::EggsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Oeufs', :admin_eggs_path

  def index
    @eggs = Egg.all
  end

  def edit
    @egg = Egg.friendly.find(params[:id])
    breadcrumb @egg.name, edit_admin_egg_path(@egg)
  end

  def new
    @egg = Egg.new
  end

  def create
    @egg = Egg.create!(egg_params)
    redirect_to edit_admin_egg_path(@egg)
  end

  def update
    @egg = Egg.friendly.find(params[:id])
    if @egg.update(egg_params)
      redirect_to admin_eggs_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def egg_params
      params.require(:egg).permit(:name, :desc, {:pokemon_ids => []})
    end
end