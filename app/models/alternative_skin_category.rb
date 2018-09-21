class AlternativeSkinCategory < ApplicationRecord
  include Fae::BaseModelConcern

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
