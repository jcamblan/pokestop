class Article < ApplicationRecord
  include Fae::BaseModelConcern

  has_and_belongs_to_many :article_categories
  has_fae_image :illustration

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    title
  end

end
