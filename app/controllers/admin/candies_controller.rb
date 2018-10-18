class Admin::CandiesController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Bonbons', :admin_candies_path

  def index
    @candies = Candy.all
  end

  def edit
    @candy = Candy.find(params[:id])
    breadcrumb @candy.name, edit_admin_candy_path(@candy)
  end

  def new
    @candy = Candy.new
  end

  def create
    @candy = Candy.create!(candy_params)
    redirect_to edit_admin_candy_path(@candy)
  end

  def update
    @candy = Candy.find(params[:id])
    if @candy.update(candy_params)
      redirect_to admin_candies_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def candy_params
      params.require(:candy).permit(:name, :name_en, :primary_color, :secondary_color)
    end
end