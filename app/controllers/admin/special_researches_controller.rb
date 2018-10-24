class Admin::SpecialResearchesController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Etudes spéciales', :admin_special_researches_path

  def index
    @special_researchs = SpecialResearch.all
  end

  def edit
    @special_research = SpecialResearch.friendly.find(params[:id])
    breadcrumb @special_research.name, edit_admin_special_research_path(@special_research)
  end

  def new
    @special_research = SpecialResearch.new
  end

  def create
    @special_research = SpecialResearch.new(special_research_params)
    if @special_research.save
      redirect_to edit_admin_special_research_path(@special_research)
    else
      render 'new'
    end
  end

  def update
    @special_research = SpecialResearch.friendly.find(params[:id])
    if @special_research.update(special_research_params)
      redirect_to admin_special_researches_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def special_research_params
      params.require(:special_research).permit(:name, :desc, :is_active)
    end
end