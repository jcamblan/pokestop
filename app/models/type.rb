class Type < ApplicationRecord
  include Fae::BaseModelConcern

  has_and_belongs_to_many :pokemons
  has_many :attacks
  has_fae_image :logo

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
  
  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
