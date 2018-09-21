class Candy < ApplicationRecord
  include Fae::BaseModelConcern

  #------------------------------------------------------------------------
  # récupération du nom et du chemin des images de bonbons.
  # utilisés pour la génération des images et pour l'affichage en front
  #------------------------------------------------------------------------

  def image_path
    return "candy/#{self.image_name}.png"
  end

  def image_name
    return name_en.parameterize
  end

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end


end
