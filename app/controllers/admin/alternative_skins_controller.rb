class Admin::AlternativeSkinsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Alt. skins', :admin_alternative_skins_path

  def index
    @alternative_skins = AlternativeSkin.all
  end

  def edit
    @alternative_skin = AlternativeSkin.find(params[:id])
    breadcrumb @alternative_skin.name, edit_admin_alternative_skin_path(@alternative_skin)
  end

  def new
    @alternative_skin = AlternativeSkin.new
  end

  def create
    @alternative_skin = AlternativeSkin.new(alternative_skin_params)
    if @alternative_skin.save
      redirect_to edit_admin_alternative_skin_path(@alternative_skin)
    else
      render 'new'
    end
  end

  def update
    @alternative_skin = AlternativeSkin.find(params[:id])
    if @alternative_skin.update(alternative_skin_params)
      redirect_to admin_alternative_skins_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def alternative_skin_params
      params.require(:alternative_skin).permit(:name, :name_en, :pokemon_id, :shiny, :desc, :nametag)
    end
end