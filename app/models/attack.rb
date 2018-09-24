class Attack < ApplicationRecord

  belongs_to :attack_category
  has_and_belongs_to_many :pokemons
  belongs_to :type

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end

end
