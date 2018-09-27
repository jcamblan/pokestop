class Evolution < ApplicationRecord

  belongs_to :pokemon
  belongs_to :item, required: false

  #------------------------------------------------------------------------
  # retourne l'objet évolutif associé à l'évolution si il y en a un
  #------------------------------------------------------------------------

  def self.item
    return Item.find(item_id) if item_id
  end

end
