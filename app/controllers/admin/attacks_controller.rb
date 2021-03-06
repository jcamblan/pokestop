class Admin::AttacksController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Attaques', :admin_attacks_path

  def index
    @fast_attacks = Attack.where(attack_category: 1).order(:id)
    @charge_attacks = Attack.where(attack_category: 2).order(:id)
  end

  def edit
    @attack = Attack.friendly.find(params[:id])
    breadcrumb @attack.name, edit_admin_attack_path(@attack)
  end

  def update
    @attack = Attack.friendly.find(params[:id])
    if @attack.update(attack_params)
      redirect_to admin_attacks_path
    else
      render 'edit'
    end
  end

  def new
    @attack = Attack.new
  end

  def create
    @attack = Attack.new(attack_params)
    if @attack.save
      redirect_to admin_attacks_path
    else
      render 'new'
    end  
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def attack_params
      params.require(:attack).permit(:name, :name_en, :type_id, :attack_category_id, 
                                     :epu, :power, :cast_time, :energy_bars)
    end
end