class Egg < ApplicationRecord

  has_and_belongs_to_many :pokemons, touch: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

end
