class Attack < ApplicationRecord

  belongs_to :attack_category, touch: true
  has_and_belongs_to_many :pokemons
  belongs_to :type, touch: true

  validates :name, presence: true
  validates :cast_time, numericality: true, :allow_nil => true
  validates :power, numericality: true, :allow_nil => true
  validates :epu, numericality: true, :allow_nil => true
  validates :energy_bars, numericality: { only_integer: true }, :allow_nil => true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]


  # STAB (Same Type Pokemon Bonus) : bonus de 20% aux dégâts si le type du pokémon est le même
  # que celui de l'attaque
  def dps(*stab_test)
    dps = (self.power / self.cast_time)
    dps = dps *= 1.2 if stab_test.first && stab_test.first.types.include?(self.type)
    return dps.round(2)
  end

end
