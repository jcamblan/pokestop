class Item < ApplicationRecord

  belongs_to :item_category

  extend FriendlyId
  friendly_id :name, use: :slugged

  def pokemons
    item_pokemons = Array.new
    if Evolution.where(item_id: self.id)
      Evolution.where(item_id: self.id).each do |e|
        item_pokemons << Pokemon.find(e.after_evolution)
      end
    end
    return item_pokemons
  end

end
