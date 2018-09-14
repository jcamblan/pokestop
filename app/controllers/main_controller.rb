class MainController < ApplicationController

  def index
  
  end

  def search
    @pokemons = Pokemon.ransack(name_cont: params[:q]).result(distinct: true)
    @items = Item.ransack(name_cont: params[:q]).result(distinct: true)
    @generations = Generation.ransack(name_cont: params[:q]).result(distinct: true)

    respond_to do |format| 
      format.html {}
      format.json {
        @pokemons = @pokemons.limit(5)
        @items = @items.limit(5)
        @generations = @generations.limit(5)
      }
    end 
  end

  def export
    @generations = Generation.all
    @types = Type.all.order(:name)
    @candies = Candy.all.order(:name)
    @pokemons = Pokemon.all.order(:num)
    @evolutions = Evolution.all
    @item_categories = ItemCategory.all.order(:name)
    @items = Item.all.order(:item_category_id)
  end

end
