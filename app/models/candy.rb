class Candy < ApplicationRecord

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

end
