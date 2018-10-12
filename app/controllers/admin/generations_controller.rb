class Admin::GenerationsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Générations', :admin_generations_path

  def index
    @generations = Generation.all.order(:id)
  end

  def edit
    @generation = Generation.friendly.find(params[:id])
    breadcrumb @generation.name, edit_admin_generation_path(@generation)
  end

  def new
    @generation = Generation.new
  end

  def update
    @generation = Generation.friendly.find(params[:id])
    if @generation.update(generation_params)
      redirect_to admin_generations_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def generation_params
      params.require(:generation).permit(:name, :on_prod)
    end
end