class Admin::ResearchRewardsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Etudes spéciales', :admin_special_researches_path
  breadcrumb 'Etapes', :admin_research_steps_path
  breadcrumb 'Récompenses', :admin_research_rewards_path

  def index
    @research_rewards = ResearchReward.all
  end

  def edit
    @research_reward = ResearchReward.find(params[:id])
    breadcrumb @research_reward.name, edit_admin_research_reward_path(@research_reward)
  end

  def new
    @research_reward = ResearchReward.new
  end

  def create
    @research_reward = ResearchReward.new(research_reward_params)
    if @research_reward.save
      redirect_to edit_admin_research_reward_path(@research_reward)
    else
      render 'new'
    end
  end

  def update
    @research_reward = ResearchReward.find(params[:id])
    if @research_reward.update(research_reward_params)
      redirect_to admin_research_rewards_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def research_reward_params
      params.require(:research_reward).permit(:name, :reward_type, :pokemon_id, :item_id, :candy_id, :quantity, :research_step_id)
    end
end