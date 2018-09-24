class Evolution < ApplicationRecord

  belongs_to :pokemon

  #------------------------------------------------------------------------
  # retourne l'objet évolutif associé à l'évolution si il y en a un
  #------------------------------------------------------------------------

  def item
    return Item.find(item_id) if item_id
  end

end
