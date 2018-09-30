class Attack < ApplicationRecord

  belongs_to :attack_category
  has_and_belongs_to_many :pokemons
  belongs_to :type



end
