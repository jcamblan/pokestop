class Evolution < ApplicationRecord

  belongs_to :pokemon, touch: true
  belongs_to :item, required: false, touch: true

  #------------------------------------------------------------------------
  # retourne l'objet évolutif associé à l'évolution si il y en a un
  #------------------------------------------------------------------------

  def self.item
    return Item.find(item_id) if item_id
  end

end
