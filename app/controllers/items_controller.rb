class ItemsController < ApplicationController

  breadcrumb 'Objets', :items_path

  def index
    @items_categories = ItemCategory.all.order(:name)
  end

  def show
    redirect_to "#{items_path}##{params[:id]}"
  end
end