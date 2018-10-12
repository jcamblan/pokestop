class Generation < ApplicationRecord
  
  has_many :pokemons

  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  #------------------------------------------------------------------------
  # pour la gem filterrific
  #------------------------------------------------------------------------

  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end

end


