class Admin::ResearchStepsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Etudes spéciales', :admin_special_researches_path
  breadcrumb 'Etapes', :admin_research_steps_path

  def index
    @research_steps = ResearchStep.all
  end

  def edit
    @research_step = ResearchStep.find(params[:id])
    breadcrumb "Etape #{@research_step.step_id.to_s}", edit_admin_research_step_path(@research_step)
  end

  def new
    @research_step = ResearchStep.new
  end

  def create
    @research_step = ResearchStep.new(research_step_params)
    if @research_step.save
      redirect_to edit_admin_research_step_path(@research_step)
    else
      render 'new'
    end
  end

  def update
    @research_step = ResearchStep.find(params[:id])
    if @research_step.update(research_step_params)
      redirect_to admin_research_steps_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def research_step_params
      params.require(:research_step).permit(:name, :special_research_id, :step_id)
    end
end