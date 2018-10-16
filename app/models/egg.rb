class Egg < ApplicationRecord

  has_and_belongs_to_many :pokemons,
                          after_add: :touch_updated_at,
                          after_remove: :touch_updated_at

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  def touch_updated_at(pokemon)
    self.touch if persisted?
  end

end
