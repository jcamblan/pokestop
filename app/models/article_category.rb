class ArticleCategory < ApplicationRecord
  include Fae::BaseModelConcern

  has_and_belongs_to_many :articles

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
