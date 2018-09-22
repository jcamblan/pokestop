class Generation < ApplicationRecord
  include Fae::BaseModelConcern

  has_many :pokemons


  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end
  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

  #------------------------------------------------------------------------
  # pour la gem filterrific
  #------------------------------------------------------------------------

  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end

end


