class MainController < ApplicationController

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

end
