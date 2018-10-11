class Admin::ItemsController < ApplicationController
  layout 'admin'
  load_and_authorize_resource

  breadcrumb 'Admin', :admin_path
  breadcrumb 'Objets', :admin_items_path

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
    breadcrumb @item.name, edit_admin_item_path(@item)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create!(item_params)
    redirect_to edit_admin_item_path(@item)
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_items_path
    else
      render 'edit'
    end
  end

  private

    def current_ability
      @current_ability ||= AdminAbility.new(current_user)
    end

    def item_params
      params.require(:item).permit(:name, :name_en, :desc, :item_category_id)
    end
end