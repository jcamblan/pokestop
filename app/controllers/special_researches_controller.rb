class SpecialResearchesController < ApplicationController

  breadcrumb 'Etudes spéciales', :special_researches_path

  def index
    @researches = SpecialResearch.all.order(:id)
  end

  def show
    @research = SpecialResearch.friendly.find(params[:id])
    breadcrumb @research.name, special_research_path(@research)
  end

end