class Item < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :item_category
  has_fae_image :illustration

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
