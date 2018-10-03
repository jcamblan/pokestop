class Type < ApplicationRecord

  has_and_belongs_to_many :pokemons
  has_many :attacks

  has_and_belongs_to_many :strengths,
                          :class_name => "Type",
                          :join_table => "strengths_types",
                          :foreign_key => "type_id",
                          :association_foreign_key => "strength_id"
  has_and_belongs_to_many :weaknesses,
                          :class_name => "Type",
                          :join_table => "types_weaknesses",
                          :foreign_key => "type_id",
                          :association_foreign_key => "weakness_id"
  has_and_belongs_to_many :extreme_weaknesses,
                          :class_name => "Type",
                          :join_table => "extreme_weaknesses_types",
                          :foreign_key => "type_id",
                          :association_foreign_key => "extreme_weakness_id"

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
