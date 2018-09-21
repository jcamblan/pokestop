class AttackCategory < ApplicationRecord
  include Fae::BaseModelConcern

  has_many :attacks

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

end
