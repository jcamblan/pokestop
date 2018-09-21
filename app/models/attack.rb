class Attack < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :attack_category
  has_and_belongs_to_many :pokemons
  belongs_to :type

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
