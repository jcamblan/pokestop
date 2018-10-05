class Attack < ApplicationRecord

  belongs_to :attack_category
  has_and_belongs_to_many :pokemons
  belongs_to :type

  validates :name, presence: true
  validates :cast_time, numericality: true, :allow_nil => true
  validates :power, numericality: true, :allow_nil => true
  validates :epu, numericality: true, :allow_nil => true
  validates :energy_bars, numericality: { only_integer: true }, :allow_nil => true


  # STAB (Same Type Pokemon Bonus) : bonus de 20% aux dégâts si le type du pokémon est le même
  # que celui de l'attaque
  def dps(*stab_test)
    dps = (self.power / self.cast_time)
    dps = dps *= 1.2 if stab_test.first && stab_test.first.types.include?(self.type)
    return dps.round(1)
  end

end
