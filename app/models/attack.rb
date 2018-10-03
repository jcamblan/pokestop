class Attack < ApplicationRecord

  belongs_to :attack_category
  has_and_belongs_to_many :pokemons
  belongs_to :type

  validates :name, presence: true
  validates :cast_time, numericality: true, :allow_nil => true
  validates :power, numericality: true, :allow_nil => true
  validates :epu, numericality: true, :allow_nil => true
  validates :energy_bars, numericality: { only_integer: true }, :allow_nil => true

end
