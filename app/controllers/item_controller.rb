class ItemController < ApplicationController
  def index
    @items_categories = ItemCategory.all.order(:name)
  end
end