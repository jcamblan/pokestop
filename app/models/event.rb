class Event < ApplicationRecord
  include Fae::BaseModelConcern

  has_fae_image :illustration

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    title
  end

end
