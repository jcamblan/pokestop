class Egg < ApplicationRecord

  has_and_belongs_to_many :pokemons

  extend FriendlyId
  friendly_id :name, use: :slugged

end
