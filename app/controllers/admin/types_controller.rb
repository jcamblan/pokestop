class Admin::TypesController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Types', :admin_types_path

  def index
    @types = Type.all
  end

  def edit
    @type = Type.friendly.find(params[:id])
    breadcrumb @type.name, edit_admin_type_path(@type)
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)
    if @type.save
      redirect_to edit_admin_type_path(@type)
    else
      render 'new'
    end
  end

  def update
    @type = Type.friendly.find(params[:id])
    if @type.update(type_params)
      redirect_to admin_types_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def type_params
      params.require(:type).permit(:name,:name_en,{:strength_ids => []},{:weakness_ids => []},{:extreme_weakness_ids => []})
    end
end