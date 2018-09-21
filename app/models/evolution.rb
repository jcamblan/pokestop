class Evolution < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :pokemon

  #------------------------------------------------------------------------
  # retourne l'objet évolutif associé à l'évolution si il y en a un
  #------------------------------------------------------------------------

  def item
    return Item.find(item_id) if item_id
  end

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    title
  end

end
