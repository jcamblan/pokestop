class PokemonController < ApplicationController

  def share

  	list = Json.new

  	list.create

  	render json: list

  end

end
