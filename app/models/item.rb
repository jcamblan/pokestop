class Item < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :item_category
  has_fae_image :illustration

  def pokemons
    item_pokemons = Array.new
    if Evolution.where(item_id: self.id)
      Evolution.where(item_id: self.id).each do |e|
        item_pokemons << Pokemon.find(e.after_evolution)
      end
    end
    return item_pokemons
  end

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
