class Type < ApplicationRecord

  has_and_belongs_to_many :pokemons
  has_many :attacks

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

  #------------------------------------------------------------------------
  # pour la gem filterrific
  #------------------------------------------------------------------------

  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end

end
