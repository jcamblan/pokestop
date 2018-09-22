class ItemCategory < ApplicationRecord
  include Fae::BaseModelConcern

  has_many :items
  
  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
