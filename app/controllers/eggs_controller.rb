class EggsController < ApplicationController

  breadcrumb 'Oeufs', :eggs_path

  def index
    @eggs = Egg.all.order(:id)
  end
end