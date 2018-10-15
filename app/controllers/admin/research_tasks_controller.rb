class Admin::ResearchTasksController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Etudes spéciales', :admin_special_researches_path
  breadcrumb 'Etapes', :admin_research_steps_path
  breadcrumb 'Tâches', :admin_research_tasks_path

  def index
    @research_tasks = ResearchTask.all
  end

  def edit
    @research_task = ResearchTask.find(params[:id])
    breadcrumb @research_task.name, edit_admin_research_task_path(@research_task)
  end

  def new
    @research_task = ResearchTask.new
  end

  def create
    @research_task = ResearchTask.new(research_task_params)
    if @research_task.save
      redirect_to edit_admin_research_task_path(@research_task)
    else
      render 'new'
    end
  end

  def update
    @research_task = ResearchTask.find(params[:id])
    if @research_task.update(research_task_params)
      redirect_to admin_research_tasks_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def research_task_params
      params.require(:research_task).permit(:name, :research_step_id, :pokemon_id, :desc, :xp_reward)
    end
end