class ItemsController < ApplicationController

  breadcrumb 'Objets', :items_path

  def index
    @items_categories = ItemCategory.all.order(:name)
  end
end