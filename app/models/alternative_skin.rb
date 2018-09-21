class AlternativeSkin < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :pokemon
  belongs_to :alternative_skin_category
  has_fae_image :illustration

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

  belongs_to :pokemon
  belongs_to :alternative_skin_category
end
